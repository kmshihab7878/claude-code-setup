# Embeddings and Retrieval

Purpose: Embedding model selection, hybrid search, query expansion, and reranking implementation patterns.

## Embedding Model Comparison

| Model | Dimensions | Context | Strengths |
|---|---:|---:|---|
| OpenAI text-embedding-3-large | 3072 | 8191 | Best quality, multilingual |
| OpenAI text-embedding-3-small | 1536 | 8191 | Good balance of cost and quality |
| Cohere embed-v3 | 1024 | 512 | Good for reranking |
| BGE-M3 | 1024 | 8192 | Open-source, multilingual |
| all-MiniLM-L6-v2 | 384 | 256 | Fast, lightweight, local |
| nomic-embed-text | 768 | 8192 | Open-source, long context |

## Selection Criteria

- Quality vs cost.
- Latency: smaller models for real-time, larger for batch.
- Local vs API.
- Dimensionality and storage cost.
- Context length relative to chunk size.

## Hybrid Search

```python
def hybrid_search(
    query: str,
    top_k: int = 10,
    alpha: float = 0.7,
) -> list[dict]:
    """Hybrid search: alpha * vector + (1-alpha) * BM25."""
    vector_results = vector_search(query, top_k=top_k * 2)
    keyword_results = bm25_search(query, top_k=top_k * 2)

    scores: dict[str, float] = {}
    k = 60

    for rank, doc in enumerate(vector_results):
        scores[doc.id] = scores.get(doc.id, 0) + alpha / (k + rank + 1)
    for rank, doc in enumerate(keyword_results):
        scores[doc.id] = scores.get(doc.id, 0) + (1 - alpha) / (k + rank + 1)

    sorted_ids = sorted(scores, key=scores.get, reverse=True)[:top_k]
    return [get_doc(doc_id) for doc_id in sorted_ids]
```

## Query Expansion

```python
async def expand_query(original: str) -> list[str]:
    """Generate multiple search queries from one question."""
    prompt = f"""Generate 3 different search queries for: {original}
    1. Rephrase the question
    2. Break into sub-questions
    3. Use related keywords"""
    expanded = await llm_generate(prompt)
    return [original] + parse_queries(expanded)
```

## Reranking

```python
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
