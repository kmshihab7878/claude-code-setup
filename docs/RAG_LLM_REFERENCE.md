# RAG & LLM Optimization Reference

> RAG architectures, LLM serving, caching, memory systems, and evaluation
> Compiled: 2026-03-15

---

## RAG Architecture Reference

### Architecture Tiers

```
Tier 1: Naive RAG
Query → Embed → Vector Search → Top-K → LLM → Answer

Tier 2: Advanced RAG
Query → Rewrite → Embed → Hybrid Search → Rerank → LLM → Answer

Tier 3: Agentic RAG
Query → Agent → [Choose: Search, SQL, API, Calc] → Synthesize → Answer

Tier 4: Multimodal RAG (RAG-Anything)
Doc → Parse [Text+Tables+Images] → Multi-Embed → Cross-Modal Search → MLLM → Answer
```

### RAG-Anything: Multimodal Processing

Handles documents with mixed content types (PDFs with charts, slides with diagrams, technical papers with formulas).

**Key Innovation**: Treats each modality (text, table, image, diagram) as a first-class citizen with dedicated embedding and retrieval strategies.

**Document Processing Pipeline**:
1. **Layout Analysis**: Detect text regions, tables, figures, captions
2. **Element Extraction**: OCR for text, structure detection for tables, crop images
3. **Element Description**: Use vision LLM to describe charts/diagrams
4. **Multi-modal Indexing**: Embed each element type appropriately
5. **Cross-modal Retrieval**: Search across all modalities
6. **Context Assembly**: Combine relevant elements for LLM

### UltraRAG: Advanced Retrieval Patterns

**Key Concepts**:
- Knowledge graph-enhanced retrieval
- Multi-granularity indexing (document, paragraph, sentence)
- Iterative retrieval with feedback loops
- Hybrid retrieval combining dense + sparse + graph

---

## LLM Serving Options

### Comparison Matrix

| Platform | Local | Multi-GPU | Quantization | API | Best For |
|----------|-------|-----------|-------------|-----|----------|
| **Ollama** | Yes | No | GGUF | REST | Simple local inference |
| **vLLM** | Yes | Yes | AWQ, GPTQ | OpenAI-compat | Production serving |
| **llama.cpp** | Yes | No | GGUF | REST | Minimal deps, CPU |
| **MLC-LLM** | Yes | Yes | Mixed | REST | Mobile/edge/browser |
| **TGI** (HF) | Yes | Yes | GPTQ, AWQ | REST | HF model hub integration |
| **SGLang** | Yes | Yes | AWQ | REST | Structured generation |

### MLC-LLM: Universal Deployment

**Key Value**: Deploy LLMs anywhere — mobile (iOS/Android), browser (WebGPU), edge devices, GPUs.

**Architecture**:
```
Model (HF) → Compile (TVM) → Optimize → Deploy
                                    ├── iOS (Metal)
                                    ├── Android (OpenCL/Vulkan)
                                    ├── Browser (WebGPU)
                                    ├── GPU (CUDA/ROCm)
                                    └── CPU (x86/ARM)
```

**Khaled's Integration**: Complements existing Ollama setup for scenarios needing mobile/browser LLM inference.

---

## Caching Strategies (LMCache Concepts)

### KV Cache Sharing
```
Request 1: [System Prompt | User Query 1]
Request 2: [System Prompt | User Query 2]
                ↑
          Shared KV cache for system prompt
          (eliminates redundant computation)
```

**Benefits**:
- 2-10x speedup for requests sharing system prompts
- Reduced GPU memory usage
- Lower cost per request

### Semantic Cache
```python
# Cache responses for semantically similar queries
class SemanticCache:
    """Cache LLM responses keyed by query similarity."""

    def __init__(self, threshold: float = 0.95) -> None:
        self.threshold = threshold
        self.entries: list[tuple[list[float], str, str]] = []  # (embedding, query, response)

    async def lookup(self, query: str) -> str | None:
        """Return cached response if similar query exists."""
        query_emb = await embed(query)
        for cached_emb, cached_query, cached_response in self.entries:
            if cosine_similarity(query_emb, cached_emb) > self.threshold:
                return cached_response
        return None
```

### Prompt Caching (Anthropic)
- Claude supports automatic prompt caching for system prompts
- Cache hits reduce cost by 90% and latency by 80%
- Minimum 1024 tokens for cache eligibility

---

## Memory System Architectures

### Memory Types for AI Agents

| Type | Retention | Use Case | Implementation |
|------|-----------|----------|---------------|
| **Working** | Current session | Active reasoning | Context window |
| **Episodic** | Long-term, event-based | Past experiences | Vector DB |
| **Semantic** | Long-term, factual | Knowledge base | Knowledge graph |
| **Procedural** | Long-term, skill-based | Tool usage patterns | Skill definitions |

### SuperMemory Architecture
```
User Input → Memory Router → [Store / Retrieve / Forget]
                                 ↓
                          ┌──────┴──────┐
                          │ Memory Index │
                          │ (Embeddings) │
                          └──────┬──────┘
                                 │
                    ┌────────────┼────────────┐
                    │            │            │
               ┌────▼───┐  ┌───▼────┐  ┌───▼────┐
               │Personal│  │Project │  │Global  │
               │Memory  │  │Memory  │  │Memory  │
               └────────┘  └────────┘  └────────┘
```

### Memary: Agent Memory Graph
- Entities + relationships as knowledge graph
- Temporal decay for relevance scoring
- Automatic summarization of old memories
- Integration with vector search for retrieval

### Khaled's Memory Stack
```
~/.claude/projects/-Users-redacted-username/memory/
├── MEMORY.md          ← Index (auto-loaded)
├── architecture.md    ← System overviews
├── decisions.md       ← ADR log
├── mistakes.md        ← Error journal
└── patterns.md        ← Code patterns

memory MCP server (8 tools)
├── create_entities    ← Add knowledge nodes
├── create_relations   ← Link nodes
├── add_observations   ← Append facts
├── search_nodes       ← Semantic search
├── read_graph         ← Full graph
├── open_nodes         ← Read specific nodes
├── delete_entities    ← Remove nodes
└── delete_relations   ← Remove links
```

---

## Evaluation Metrics

### RAG System Metrics

| Metric | Measures | How to Compute |
|--------|----------|---------------|
| **Faithfulness** | Answer supported by retrieved context | LLM judge: does answer contain only info from context? |
| **Answer Relevance** | Answer addresses the question | LLM judge: does answer help with the question? |
| **Context Relevance** | Retrieved chunks are relevant | Proportion of relevant sentences in context |
| **Context Recall** | Context covers the ground truth | Proportion of ground truth covered by context |
| **Context Precision** | Relevant chunks ranked higher | Mean reciprocal rank of relevant chunks |
| **Answer Correctness** | Answer matches ground truth | Factual overlap + semantic similarity |

### Evaluation Frameworks
- **RAGAS**: Python library for RAG evaluation
- **LangSmith**: Tracing + evaluation platform
- **DeepEval**: Open-source LLM evaluation
- **Custom**: LLM-as-judge with rubric

---

## Production RAG Checklist

- [ ] **Chunking**: Right strategy for document type (recursive for prose, table-aware for structured)
- [ ] **Embeddings**: Evaluated multiple models, selected best for domain
- [ ] **Retrieval**: Hybrid search (vector + BM25) with reranking
- [ ] **Guardrails**: Handle "I don't know" gracefully when context insufficient
- [ ] **Caching**: Semantic cache for common queries, KV cache for system prompts
- [ ] **Monitoring**: Track retrieval quality, latency, cost, user satisfaction
- [ ] **Versioning**: Version embeddings, chunks, and prompts together
- [ ] **Testing**: Evaluation set with ground truth answers
- [ ] **Security**: No PII in embeddings, access control on documents
- [ ] **Fallback**: Graceful degradation when retrieval fails

---

## Vector Database Quick Reference

### Selection Guide

| If you need... | Use |
|---------------|-----|
| Already using PostgreSQL | pgvector |
| Fastest vector search | Qdrant or Milvus |
| Managed cloud service | Pinecone |
| Hybrid text + vector | Weaviate |
| Embedded/local only | ChromaDB |
| Multi-tenant SaaS | Pinecone or Qdrant Cloud |

### pgvector with JARVIS
```sql
-- JARVIS already uses PostgreSQL via SQLAlchemy
CREATE EXTENSION vector;

CREATE TABLE document_chunks (
    id BIGSERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    embedding vector(1536),
    metadata JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX ON document_chunks USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);
```

---

## Cross-References

- **rag-patterns** skill: Chunking, retrieval, multimodal RAG code patterns
- **memory** MCP server: Persistent knowledge graph
- **context7** MCP server: Library documentation retrieval
- **document-handling** skill: Document parsing patterns
- **pdf** skill: PDF text/table extraction
- **research-methodology** skill: Source quality assessment
