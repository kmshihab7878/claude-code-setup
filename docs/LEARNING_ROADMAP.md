# Learning Roadmap & Curated Resources

> Curated learning paths and tool collections mapped to Khaled's environment
> Compiled: 2026-03-15

---

## Learning Tracks

### Track 1: AI/ML Engineering

**Progression**: Fundamentals → ML Basics → Deep Learning → LLM Engineering → Agent Systems

| Stage | Topics | Resources | Time |
|-------|--------|-----------|------|
| 1. Fundamentals | Python, Linear Algebra, Probability, Statistics | fast.ai, 3Blue1Brown, Khan Academy | 4-6 weeks |
| 2. ML Basics | Supervised/unsupervised, sklearn, feature engineering | Andrew Ng ML Coursera, Hands-On ML (Géron) | 6-8 weeks |
| 3. Deep Learning | CNNs, RNNs, Transformers, PyTorch | fast.ai Practical DL, d2l.ai | 8-10 weeks |
| 4. LLM Engineering | Prompting, fine-tuning, RAG, evaluation | AI Engineering book (Chip Huyen), LLM course | 6-8 weeks |
| 5. Agent Systems | Multi-agent, tool use, planning, memory | AG2 docs, JARVIS architecture, agent-orchestration skill | Ongoing |

**Key Book: AI Engineering (Chip Huyen)**:
- Covers production AI systems end-to-end
- Topics: evaluation, prompt engineering, RAG, fine-tuning, agents
- Practical focus: what works in production vs. research
- Publisher: O'Reilly (2024)

### Track 2: LLM Application Development

| Topic | Key Pattern | Khaled's Skill/Agent |
|-------|------------|---------------------|
| Prompt Engineering | System prompts, few-shot, chain-of-thought | claude-api skill |
| RAG Systems | Chunk → embed → retrieve → generate | rag-patterns skill |
| Agent Frameworks | ReAct, Plan-and-Execute, multi-agent | agent-orchestration skill |
| Fine-Tuning | LoRA, QLoRA, data preparation | N/A (learning opportunity) |
| Evaluation | RAGAS, LLM-as-judge, human eval | quality-engineer agent |
| Deployment | vLLM, Ollama, edge deployment | devops-patterns skill |

### Track 3: Data Structures & Algorithms

**Core Topics** (from best-data-structures):

| Category | Must Know | Advanced |
|----------|-----------|---------|
| Arrays/Strings | Two pointers, sliding window | Monotonic stack/queue |
| Linked Lists | Reversal, fast/slow pointers | Skip lists, LRU cache |
| Trees | BFS, DFS, BST operations | Segment trees, Fenwick |
| Graphs | BFS, DFS, topological sort | Dijkstra, A*, network flow |
| Dynamic Programming | 1D/2D DP, memoization | Bitmask DP, digit DP |
| Sorting/Searching | Binary search, merge sort | External sorting |
| Hash Tables | Design, collision handling | Bloom filters, consistent hashing |

**Practice Platforms**: LeetCode, NeetCode 150, HackerRank, Project Euler

### Track 4: DevOps & Infrastructure

| Topic | Key Skills | Khaled's Tools |
|-------|-----------|----------------|
| Containers | Docker, multi-stage builds, security | docker-specialist agent |
| Orchestration | Kubernetes, Helm, operators | infra-engineer agent |
| IaC | Terraform modules, state management | devops-patterns skill |
| CI/CD | GitHub Actions, OIDC, caching | ci-cd-engineer agent |
| Monitoring | Prometheus, Grafana, OpenTelemetry | devops-patterns skill |
| Security | Supply chain, secrets, RBAC | security-review skill |

---

## Curated Tool Collections

### Top AI Tools Not in Khaled's Setup

| Tool | Category | Why Notable |
|------|----------|-------------|
| **Cursor** | AI IDE | VS Code fork with AI built-in |
| **Aider** | AI Pair Programmer | CLI coding assistant (Git-aware) |
| **Open Interpreter** | Code Executor | Natural language → code execution |
| **GPT-Engineer** | Code Generator | Prompt → full project |
| **Phidata** | Agent Framework | Simple agent building with tools |
| **Instructor** | Structured Output | Pydantic-validated LLM outputs |
| **Outlines** | Constrained Gen | Guaranteed structured LLM output |
| **LiteLLM** | LLM Gateway | Unified API for 100+ LLMs |
| **LangFuse** | LLM Observability | Tracing, evaluation, analytics |
| **Weights & Biases** | ML Ops | Experiment tracking, model registry |

### Best LLM Apps (from awesome-llm-apps)

| App | What It Does | Pattern |
|-----|-------------|---------|
| Local RAG chatbot | Chat with documents locally | RAG + Ollama |
| AI research assistant | Multi-source paper synthesis | Agentic RAG |
| Code review bot | Automated PR review | Agent + GitHub API |
| SQL chat | Natural language → database queries | NL2SQL |
| Meeting summarizer | Audio → structured notes | STT + LLM |
| Email assistant | Draft, summarize, categorize | LLM + Gmail API |

### Useful Public APIs (from public-apis)

#### Finance (for Aster/FINCALC)
| API | Data | Auth |
|-----|------|------|
| CoinGecko | Crypto prices, market data | Free (rate limited) |
| Alpha Vantage | Stocks, forex, crypto | API key (free tier) |
| FRED | US economic data | API key (free) |
| Exchange Rates API | Currency exchange rates | Free |
| IEX Cloud | US stock data | API key |

#### AI/ML
| API | Purpose | Auth |
|-----|---------|------|
| Hugging Face | Models, datasets, inference | API key (free tier) |
| OpenAI | GPT, DALL-E, Whisper | API key |
| Anthropic | Claude models | API key |
| Replicate | Run ML models | API key |

#### DevOps
| API | Purpose | Auth |
|-----|---------|------|
| GitHub | Repos, issues, PRs, actions | PAT |
| GitLab | CI/CD, repos | PAT |
| Docker Hub | Container registry | API key |
| Cloudflare | DNS, CDN, workers | API key |

#### Data
| API | Purpose | Auth |
|-----|---------|------|
| Wikipedia | Knowledge base | None |
| NewsAPI | News aggregation | API key |
| OpenWeather | Weather data | API key |
| REST Countries | Country data | None |

---

## GenAI Experiments (from buildfastwithai)

### Notable Experiments Worth Trying

| Experiment | What You Learn | Complexity |
|-----------|----------------|------------|
| RAG with evaluation | Build + measure RAG quality | Medium |
| Multi-agent debate | Agents argue, judge decides | Medium |
| Code generation pipeline | Spec → code → test → review | High |
| Vision + RAG | Process images + text together | High |
| Tool-calling agent | Agent uses APIs autonomously | Medium |
| Fine-tuning experiment | LoRA fine-tune on custom data | High |

---

## AI Engineering Patterns (from aie-book)

### Production AI Checklist

| Category | Pattern |
|----------|---------|
| **Evaluation** | Always evaluate before deploying; use multiple metrics |
| **Prompting** | Version control prompts; A/B test changes |
| **RAG** | Evaluate retrieval separate from generation |
| **Fine-tuning** | Start with prompting; fine-tune only when needed |
| **Guardrails** | Input validation + output filtering |
| **Monitoring** | Track latency, cost, quality, safety metrics |
| **Caching** | Cache at semantic level, not just string match |
| **Cost** | Track per-request cost; optimize token usage |

---

## Mapping to Khaled's Environment

| Track | Relevant Skills | Relevant Agents | Projects |
|-------|----------------|-----------------|----------|
| AI/ML | finance-ml, rag-patterns, claude-api | data-analyst, python-expert | JARVIS, FINCALC |
| LLM Apps | rag-patterns, agent-orchestration | deep-research, learning-guide | JARVIS LLM |
| DS/Algo | coding-workflow | python-expert | General |
| DevOps | devops-patterns, security-review | infra-engineer, ci-cd-engineer | JARVIS deploy |

---

## Cross-References

- **finance-ml** skill: ML for financial analysis
- **rag-patterns** skill: RAG architecture patterns
- **agent-orchestration** skill: Multi-agent patterns
- **data-analysis** skill: Data exploration patterns
- **claude-api** skill: Claude API usage
- **research-methodology** skill: Research workflow
