# RAG Architecture and Chunking

Purpose: Architecture tier detail, chunking strategy comparison, recursive chunking implementation, and parent-child retrieval pattern.

## Architecture Tiers

### Tier 1: Naive RAG

```text
Query -> Embed -> Vector Search -> Top-K -> LLM -> Answer
```

Simple but limited. Suitable for prototypes and small document sets.

### Tier 2: Advanced RAG

```text
Query -> Rewrite -> Embed -> Hybrid Search -> Rerank -> LLM -> Answer
  ^                                                       |
  |---------------- Feedback Loop <----------------------|
```

Production-grade. Adds query rewriting, hybrid search, and reranking.

### Tier 3: Agentic RAG

```text
Query -> Agent Router -> [Search, SQL, API, Calculator, ...] -> Synthesize -> Answer
              ^                                                    |
              |----------- Reflection + Planning <-----------------|
```

Agent decides retrieval strategy dynamically. Best for complex questions.

### Tier 4: Multimodal RAG

```text
Document -> Parse [Text + Tables + Images + Diagrams] -> Multimodal Embeddings
Query -> Multimodal Search -> Cross-modal Rerank -> Multimodal LLM -> Answer
```

Handles mixed-content documents such as PDFs with charts and slides with diagrams.

## Chunking Strategy Comparison

| Strategy | Chunk Size | Best For | Pros | Cons |
|---|---:|---|---|---|
| Fixed-size | 256-1024 tokens | General text | Simple, predictable | Breaks semantic units |
| Recursive | Varies | Structured docs | Respects document structure | More complex |
| Semantic | Varies | Varied content | Preserves meaning | Computationally expensive |
| Sentence-based | 3-5 sentences | Factual content | Natural boundaries | May be too small |
| Document-aware | Section-level | Technical docs | Preserves context | Requires format parsing |

## Recursive Chunking

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
                prev_tail = chunks[i - 1][-self.chunk_overlap:]
                chunk = prev_tail + " " + chunk
            overlapped.append(chunk)
        return overlapped
```

## Parent-Child Chunking

```python
from dataclasses import dataclass

@dataclass
class ChunkWithParent:
    chunk_id: str
    content: str
    parent_content: str
    metadata: dict

def retrieve_with_context(query: str, top_k: int = 5) -> list[str]:
    child_results = vector_search(query, top_k=top_k)
    return [r.parent_content for r in child_results]
```
