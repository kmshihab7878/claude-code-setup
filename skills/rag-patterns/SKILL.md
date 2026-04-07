---
name: rag-patterns
description: >
  RAG architecture patterns and optimization. Chunking strategies, embedding selection,
  retrieval tuning, multimodal RAG, agentic RAG, and memory systems. Use when building
  knowledge retrieval systems, agent memory, or optimizing LLM context usage.
---

# RAG Patterns

Retrieval-Augmented Generation architecture and optimization patterns.

## how to use

- `/rag-patterns`
  Apply RAG best practices to the current system.

- `/rag-patterns <aspect>`
  Guide for: chunking, embeddings, retrieval, multimodal, agentic, evaluation.

## when to apply

Reference these guidelines when:
- building knowledge retrieval systems
- implementing document Q&A
- designing agent memory systems
- optimizing LLM context usage
- processing multimodal documents (PDFs, images, tables)
- evaluating RAG system quality

## RAG architecture tiers

### Tier 1: Naive RAG
```
Query → Embed → Vector Search → Top-K → LLM → Answer
```
Simple but limited. Suitable for prototypes and small document sets.

### Tier 2: Advanced RAG
```
Query → Rewrite → Embed → Hybrid Search → Rerank → LLM → Answer
  ↑                                                       │
  └──────────── Feedback Loop ◄────────────────────────────┘
```
Production-grade. Adds query rewriting, hybrid search, and reranking.

### Tier 3: Agentic RAG
```
Query → Agent Router → [Search, SQL, API, Calculator, ...] → Synthesize → Answer
              ↑                                                    │
              └──────── Reflection + Planning ◄────────────────────┘
```
Agent decides retrieval strategy dynamically. Best for complex questions.

### Tier 4: Multimodal RAG (RAG-Anything concepts)
```
Document → Parse [Text + Tables + Images + Diagrams] → Multimodal Embeddings
Query → Multimodal Search → Cross-modal Rerank → Multimodal LLM → Answer
```
Handles mixed-content documents: PDFs with charts, slides with diagrams.

## chunking strategies

### Strategy Comparison
| Strategy | Chunk Size | Best For | Pros | Cons |
|----------|-----------|----------|------|------|
| Fixed-size | 256-1024 tokens | General text | Simple, predictable | Breaks semantic units |
| Recursive | Varies | Structured docs | Respects document structure | Complex implementation |
| Semantic | Varies | Varied content | Preserves meaning | Computationally expensive |
| Sentence-based | 3-5 sentences | Factual content | Natural boundaries | May be too small |
| Document-aware | Section-level | Technical docs | Preserves context | Requires format parsing |

### Implementation Patterns
```python
from typing import Protocol

class ChunkingStrategy(Protocol):
    def chunk(self, text: str) -> list[str]: ...

class RecursiveChunker:
    """Chunk by document structure, then by size."""
    def __init__(
        self,
        max_chunk_size: int = 512,
        chunk_overlap: int = 50,
        separators: list[str] | None = None,
    ) -> None:
        self.max_chunk_size = max_chunk_size
        self.chunk_overlap = chunk_overlap
        self.separators = separators or ["\n\n", "\n", ". ", " "]

    def chunk(self, text: str) -> list[str]:
        chunks = []
        self._split_recursive(text, self.separators, chunks)
        return self._add_overlap(chunks)

    def _split_recursive(
        self, text: str, separators: list[str], chunks: list[str],
    ) -> None:
        if len(text) <= self.max_chunk_size:
            chunks.append(text.strip())
            return
        sep = separators[0] if separators else " "
        parts = text.split(sep)
        current = ""
        for part in parts:
            if len(current) + len(part) > self.max_chunk_size and current:
                chunks.append(current.strip())
                current = part
            else:
                current = current + sep + part if current else part
        if current.strip():
            chunks.append(current.strip())

    def _add_overlap(self, chunks: list[str]) -> list[str]:
        if self.chunk_overlap == 0:
            return chunks
        overlapped = []
        for i, chunk in enumerate(chunks):
            if i > 0:
                prev_tail = chunks[i-1][-self.chunk_overlap:]
                chunk = prev_tail + " " + chunk
            overlapped.append(chunk)
        return overlapped
```

### Parent-Child Chunking
```python
# Pattern: Store small chunks but retrieve with parent context
@dataclass
class ChunkWithParent:
    chunk_id: str
    content: str  # Small chunk for precise retrieval
    parent_content: str  # Larger context for LLM
    metadata: dict

# Retrieve on child, send parent to LLM
def retrieve_with_context(query: str, top_k: int = 5) -> list[str]:
    child_results = vector_search(query, top_k=top_k)
    # Return parent content for better LLM context
    return [r.parent_content for r in child_results]
```

## embedding selection

### Model Comparison
| Model | Dimensions | Context | Strengths |
|-------|-----------|---------|-----------|
| OpenAI text-embedding-3-large | 3072 | 8191 | Best quality, multilingual |
| OpenAI text-embedding-3-small | 1536 | 8191 | Good balance cost/quality |
| Cohere embed-v3 | 1024 | 512 | Good for reranking |
| BGE-M3 | 1024 | 8192 | Open-source, multilingual |
| all-MiniLM-L6-v2 | 384 | 256 | Fast, lightweight, local |
| nomic-embed-text | 768 | 8192 | Open-source, long context |

### Selection Criteria
- **Quality vs Cost**: Larger models → better quality → higher cost
- **Latency**: Smaller models for real-time, larger for batch
- **Local vs API**: Local (sentence-transformers) vs API (OpenAI, Cohere)
- **Dimensionality**: Higher dims → more storage → better discrimination
- **Context length**: Must exceed your chunk size

## retrieval optimization

### Hybrid Search
```python
# Pattern: Combine vector search with keyword search
def hybrid_search(
    query: str,
    top_k: int = 10,
    alpha: float = 0.7,  # Weight for vector vs keyword
) -> list[dict]:
    """Hybrid search: alpha * vector + (1-alpha) * BM25."""
    vector_results = vector_search(query, top_k=top_k * 2)
    keyword_results = bm25_search(query, top_k=top_k * 2)

    # Reciprocal Rank Fusion
    scores: dict[str, float] = {}
    k = 60  # RRF constant

    for rank, doc in enumerate(vector_results):
        scores[doc.id] = scores.get(doc.id, 0) + alpha / (k + rank + 1)
    for rank, doc in enumerate(keyword_results):
        scores[doc.id] = scores.get(doc.id, 0) + (1 - alpha) / (k + rank + 1)

    sorted_ids = sorted(scores, key=scores.get, reverse=True)[:top_k]
    return [get_doc(doc_id) for doc_id in sorted_ids]
```

### Query Expansion
```python
# Pattern: Rewrite query for better retrieval
async def expand_query(original: str) -> list[str]:
    """Generate multiple search queries from one question."""
    # Use LLM to generate query variations
    prompt = f"""Generate 3 different search queries for: {original}
    1. Rephrase the question
    2. Break into sub-questions
    3. Use related keywords"""
    expanded = await llm_generate(prompt)
    return [original] + parse_queries(expanded)
```

### Reranking
```python
# Pattern: Cross-encoder reranking of initial results
def rerank(
    query: str,
    candidates: list[str],
    model: str = "cross-encoder/ms-marco-MiniLM-L-6-v2",
    top_k: int = 5,
) -> list[tuple[str, float]]:
    """Rerank candidates using cross-encoder."""
    from sentence_transformers import CrossEncoder
    reranker = CrossEncoder(model)
    pairs = [(query, doc) for doc in candidates]
    scores = reranker.predict(pairs)
    ranked = sorted(zip(candidates, scores), key=lambda x: x[1], reverse=True)
    return ranked[:top_k]
```

## multimodal RAG (from RAG-Anything)

### Document Processing Pipeline
```python
# Pattern: Parse mixed-content documents
@dataclass
class ParsedElement:
    element_type: str  # "text", "table", "image", "diagram"
    content: str | bytes
    metadata: dict
    page_number: int
    bounding_box: tuple[float, float, float, float] | None = None

async def parse_document(file_path: str) -> list[ParsedElement]:
    """Extract all element types from a document."""
    elements = []
    # Text extraction
    elements.extend(extract_text_elements(file_path))
    # Table extraction
    elements.extend(extract_tables(file_path))
    # Image extraction
    elements.extend(extract_images(file_path))
    # Diagram/chart understanding (vision LLM)
    elements.extend(await describe_visual_elements(file_path))
    return elements
```

## agent memory patterns (from Memary/SuperMemory concepts)

### Episodic Memory
```python
@dataclass
class Episode:
    timestamp: datetime
    context: str
    action: str
    result: str
    importance: float  # 0.0 - 1.0

class EpisodicMemory:
    """Store and retrieve agent experiences."""
    def __init__(self, max_episodes: int = 1000) -> None:
        self.episodes: list[Episode] = []

    def store(self, episode: Episode) -> None:
        self.episodes.append(episode)
        if len(self.episodes) > self.max_episodes:
            self._compress()  # Merge similar episodes

    def recall(self, context: str, top_k: int = 5) -> list[Episode]:
        """Retrieve relevant past experiences."""
        # Combine recency + relevance + importance
        ...
```

### Integration with Memory MCP
```
# Khaled's memory MCP server for persistent RAG memory
mcp__memory__create_entities → Document entities
mcp__memory__add_observations → Document chunks as observations
mcp__memory__search_nodes → Semantic search across stored knowledge
mcp__memory__create_relations → Link related documents/concepts
```

## LLM caching (from LMCache concepts)

### KV Cache Sharing
- Share KV cache across requests with common prefixes
- Reduces redundant computation for system prompts
- Disk-based cache for persistence across restarts

### Semantic Cache
```python
# Pattern: Cache responses for semantically similar queries
class SemanticCache:
    def __init__(self, similarity_threshold: float = 0.95) -> None:
        self.threshold = similarity_threshold
        self.cache: list[tuple[list[float], str]] = []  # (embedding, response)

    async def get(self, query: str) -> str | None:
        query_embedding = await embed(query)
        for cached_embedding, cached_response in self.cache:
            if cosine_similarity(query_embedding, cached_embedding) > self.threshold:
                return cached_response
        return None

    async def set(self, query: str, response: str) -> None:
        query_embedding = await embed(query)
        self.cache.append((query_embedding, response))
```

## vector database selection

| Database | Type | Best For | Khaled Integration |
|----------|------|----------|-------------------|
| pgvector | PostgreSQL extension | Existing Postgres users | JARVIS PostgreSQL |
| Qdrant | Dedicated vector DB | Production scale, filtering | Docker MCP |
| ChromaDB | Embedded | Prototyping, local dev | pip install |
| Pinecone | Cloud managed | Serverless, auto-scaling | API |
| Weaviate | Hybrid search | Multimodal, GraphQL | Docker MCP |
| Milvus | Distributed | Large-scale, GPU support | Docker MCP |

## evaluation metrics

| Metric | Measures | Range |
|--------|----------|-------|
| Faithfulness | Answer supported by context | 0-1 |
| Relevance | Context relevant to query | 0-1 |
| Answer Relevance | Answer addresses the query | 0-1 |
| Context Recall | Retrieved context covers ground truth | 0-1 |
| Context Precision | Proportion of relevant chunks | 0-1 |

```python
# Pattern: RAG evaluation with RAGAS-style metrics
def evaluate_rag(
    question: str,
    answer: str,
    context: list[str],
    ground_truth: str,
) -> dict[str, float]:
    """Evaluate RAG pipeline quality."""
    return {
        "faithfulness": compute_faithfulness(answer, context),
        "relevance": compute_relevance(question, context),
        "answer_relevance": compute_answer_relevance(question, answer),
        "context_recall": compute_recall(context, ground_truth),
    }
```

## cross-references

- **memory** MCP server: Persistent knowledge graph storage
- **document-handling** skill: PDF/document parsing patterns
- **pdf** skill: PDF text/table extraction
- **context7** MCP server: Library documentation retrieval
- **research-methodology** skill: Source credibility assessment
- **RAG_LLM_REFERENCE.md**: Comprehensive RAG/LLM reference
- **JARVIS knowledge**: `JARVIS-FRESH/src/jarvis/knowledge/`
