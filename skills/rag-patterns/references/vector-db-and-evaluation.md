# Vector Databases and RAG Evaluation

Purpose: Vector database selection, evaluation metrics, RAGAS-style scoring pattern, and related skill references.

## Vector Database Selection

| Database | Type | Best For | Operator Integration |
|---|---|---|---|
| pgvector | PostgreSQL extension | Existing Postgres users | PostgreSQL-backed retrieval |
| Qdrant | Dedicated vector DB | Production scale, filtering | Containerized deployment |
| ChromaDB | Embedded | Prototyping, local dev | Python package |
| Pinecone | Cloud managed | Serverless, auto-scaling | API |
| Weaviate | Hybrid search | Multimodal, GraphQL | Containerized deployment |
| Milvus | Distributed | Large-scale, GPU support | Containerized deployment |

## Evaluation Metrics

| Metric | Measures | Range |
|---|---|---:|
| Faithfulness | Answer supported by context | 0-1 |
| Relevance | Context relevant to query | 0-1 |
| Answer Relevance | Answer addresses the query | 0-1 |
| Context Recall | Retrieved context covers ground truth | 0-1 |
| Context Precision | Proportion of relevant chunks | 0-1 |

## RAG Evaluation Pattern

```python
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

## Cross-References

- `memory` MCP server: persistent knowledge graph storage.
- `document-handling` skill: PDF/document parsing patterns.
- `pdf` skill: PDF text/table extraction.
- `context7` MCP server: library documentation retrieval.
- `research-methodology` skill: source credibility assessment.
- `RAG_LLM_REFERENCE.md`: comprehensive RAG/LLM reference.
