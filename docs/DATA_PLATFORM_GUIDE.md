# Data Platform Guide

> Data analytics tools, BI platforms, and database design tools
> Compiled: 2026-03-15

---

## Platform Comparison Matrix

### BI & Visualization

| Tool | Type | Language | Self-Host | Cloud | Best For |
|------|------|----------|-----------|-------|----------|
| **Metabase** | BI Dashboard | Clojure/Java | Docker | Cloud | Non-technical users, quick setup |
| **Apache Superset** | BI Dashboard | Python | Docker | Cloud | Data teams, SQL-heavy workflows |
| **PyGWalker** | Visual Explorer | Python | Embedded | No | Jupyter notebooks, EDA |
| **Grafana** | Monitoring | Go | Docker | Cloud | Time-series, ops dashboards |
| **Redash** | SQL Dashboard | Python | Docker | Cloud | SQL-first teams |
| **Streamlit** | Data Apps | Python | Docker | Cloud | ML demos, prototypes |

### Database Design & Management

| Tool | Type | Purpose | Deploy |
|------|------|---------|--------|
| **DrawDB** | Visual Designer | ER diagram → SQL DDL | Web (static) |
| **Teable** | No-Code DB | Airtable alternative, PostgreSQL-backed | Docker |
| **SQL Studio** | SQL IDE | Single-binary SQLite/PostgreSQL/MySQL browser | Binary |
| **DBeaver** | SQL IDE | Universal database client | Desktop |
| **pgAdmin** | PostgreSQL | PostgreSQL admin GUI | Docker |

### Data Integration & ETL

| Tool | Type | Purpose | Deploy |
|------|------|---------|--------|
| **Airbyte** | ELT Platform | 300+ connectors, sync data between systems | Docker |
| **dbt** | Transform | SQL-based data transformation | CLI/Cloud |
| **Dagster** | Orchestration | Data pipeline orchestrator | Docker |
| **Unstract** | Unstructured | Process unstructured docs with LLMs | Docker |

### AI-Powered Analysis

| Tool | Type | Purpose | Deploy |
|------|------|---------|--------|
| **PandasAI** | NL→Code | Chat with DataFrames in natural language | pip |
| **WrenAI** | NL→SQL | Natural language to SQL with semantic layer | Docker |
| **CSV-to-Chat** | Chat | Upload CSV, ask questions | Web |

---

## Tool Deep Dives

### Metabase
- **Architecture**: Java app + H2/PostgreSQL metadata DB
- **Key Features**: No-code query builder, auto-discovery of database schema, scheduled reports, embedded analytics, row-level permissions
- **Deploy**: `docker run -p 3000:3000 metabase/metabase`
- **Best For**: Business users who need dashboards without SQL knowledge

### Apache Superset
- **Architecture**: Python (Flask) + SQLAlchemy + various DB drivers
- **Key Features**: SQL Lab (full SQL IDE), 40+ visualization types, Jinja templating in SQL, RBAC, CSS themes
- **Deploy**: `docker compose up` (from official repo)
- **Best For**: Data engineers who think in SQL

### PyGWalker (Tableau in Python)
```python
import pygwalker as pyg
import pandas as pd

df = pd.read_csv("data.csv")
walker = pyg.walk(df)  # Opens interactive Tableau-like UI
```
- **Best For**: Quick visual exploration in Jupyter notebooks
- **No server needed**: Runs entirely in notebook

### DrawDB (Database Design)
- **Architecture**: React-based web app, generates SQL DDL
- **Key Features**: Visual ER diagrams, drag-and-drop table creation, auto-generate SQL for PostgreSQL/MySQL/SQLite/MariaDB, export to JSON/SQL
- **Deploy**: Static web app (no server needed)
- **Best For**: Designing schemas visually before implementation

### Teable (No-Code Database)
- **Architecture**: PostgreSQL-backed, Airtable-like UI
- **Key Features**: Spreadsheet interface with real database underneath, API access, views (grid, kanban, form, gallery), automations
- **Deploy**: Docker compose
- **Best For**: Non-technical team members who need database access

### Airbyte (Data Integration)
- **Architecture**: Java/Python microservices, 300+ connectors
- **Key Features**: CDC (change data capture), incremental sync, schema change handling, connector marketplace, Terraform provider
- **Deploy**: `docker compose up` or Airbyte Cloud
- **Best For**: Consolidating data from multiple sources

### WrenAI (AI Data Modeling)
- **Architecture**: Semantic layer + LLM → SQL generation
- **Key Features**: Define business logic as semantic model, natural language queries generate correct SQL, supports multiple databases
- **Deploy**: Docker
- **Best For**: Teams wanting NL→SQL with business context

---

## Integration with Khaled's Environment

### Docker MCP Deployments
```bash
# Deploy Metabase
docker run -d --name metabase -p 3000:3000 metabase/metabase

# Deploy Superset
docker compose -f superset/docker-compose.yml up -d

# Deploy Airbyte
docker compose -f airbyte/docker-compose.yml up -d

# Deploy Teable
docker compose -f teable/docker-compose.yml up -d
```

### Skill & Agent Mapping

| Khaled Component | Data Platform Integration |
|-----------------|--------------------------|
| `data-analysis` skill | PandasAI + PyGWalker patterns |
| `data-analyst` agent | Delegates to BI tools |
| `database-patterns` skill | DrawDB design → SQL generation |
| `db-admin` agent | SQL Studio / pgAdmin workflows |
| `xlsx` skill | CSV/Excel ↔ database import/export |
| `Docker` MCP | Deploy all self-hosted tools |

### JARVIS Integration
- **JARVIS PostgreSQL**: Direct connection for Metabase/Superset dashboards
- **JARVIS API**: Airbyte connector for data pipeline
- **JARVIS knowledge**: Feed analysis results into knowledge system

---

## Data Pipeline Architecture Patterns

### Modern Data Stack
```
Sources → Airbyte (Extract/Load) → PostgreSQL (Data Warehouse)
                                          ↓
                                    dbt (Transform)
                                          ↓
                                  Metabase/Superset (Visualize)
```

### Lightweight Analytics Stack
```
CSV/Excel → pandas + PyGWalker (Explore)
                     ↓
             Streamlit (Dashboard)
                     ↓
             Report (xlsx/pdf output)
```

---

## Cross-References

- **data-analysis** skill: NL→pandas, SQL patterns, ETL pipelines
- **database-patterns** skill: Schema design, migrations, indexing
- **xlsx** skill: Spreadsheet operations
- **data-analyst** agent: Statistical analysis
- **db-admin** agent: Database administration
- **Docker** MCP: Container deployment
