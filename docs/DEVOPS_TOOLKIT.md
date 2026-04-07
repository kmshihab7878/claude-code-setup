# DevOps & Infrastructure Toolkit

> Infrastructure tools mapped to Khaled's environment
> Covers: desktop apps, dev environments, monitoring, task queues, data anonymization, IoT, IT management
> Compiled: 2026-03-15

---

## Tool Matrix

| Tool | Category | Language | Deploy | License | Key Feature |
|------|----------|----------|--------|---------|-------------|
| **Tauri** | Desktop Apps | Rust + Web | Binary | MIT/Apache | Lightweight Electron alternative |
| **Devbox** | Dev Environments | Go (Nix) | CLI | Apache-2.0 | Reproducible dev shells |
| **Nezha** | Server Monitoring | Go | Docker | Apache-2.0 | Lightweight monitoring dashboard |
| **Hatchet** | Task Queue | Go | Docker | MIT | DAG-based distributed tasks |
| **Neosync** | Data Privacy | Go | Docker | MIT | Synthetic data & anonymization |
| **ByteChef** | Automation | Java | Docker | Apache-2.0 | Open-source Zapier alternative |
| **MQTTX** | IoT/MQTT | TypeScript | Desktop/CLI | Apache-2.0 | MQTT 5.0 client |
| **GLPI** | IT Management | PHP | Docker | GPL-3.0 | IT asset management + ticketing |
| **Fleetbase** | Logistics | PHP | Docker | AGPL-3.0 | Fleet/delivery management |

---

## Desktop App Development

### Tauri (Rust + WebView)

**Why over Electron**:
- ~10x smaller binaries (5-10MB vs 100MB+)
- ~5x less RAM usage
- Native OS webview (no bundled Chromium)
- Rust backend for performance-critical logic

**Architecture**:
```
┌─────────────────────────────────┐
│         Frontend (Web)          │
│  HTML/CSS/JS • React • Vue     │
├─────────────────────────────────┤
│        Tauri Bridge (IPC)       │
├─────────────────────────────────┤
│       Backend (Rust Core)       │
│  Commands • Events • State      │
├─────────────────────────────────┤
│        OS Webview (Native)      │
│  WebKit (macOS) • WebView2 (Win)│
└─────────────────────────────────┘
```

**CLI Quick Start**:
```bash
# Create project
npm create tauri-app@latest

# Development
npm run tauri dev

# Build for production
npm run tauri build
```

**When to Use**: Desktop apps where binary size and RAM matter. Khaled's `jarvis-desktop` could benefit from Tauri migration.

---

## Dev Environment Management

### Devbox (Nix-based)

**Value**: Reproducible, isolated development environments without Docker overhead.

```bash
# Initialize project
devbox init

# Add packages
devbox add python@3.11 nodejs@20 postgresql@16

# Enter shell with all packages
devbox shell

# Run commands in devbox environment
devbox run python main.py

# Generate Docker-compatible environment
devbox generate dockerfile
```

**devbox.json**:
```json
{
  "packages": ["python@3.11", "nodejs@20", "uv@latest", "postgresql@16"],
  "shell": {
    "init_hook": ["uv sync", "npm install"],
    "scripts": {
      "dev": "python -m uvicorn main:app --reload",
      "test": "pytest"
    }
  }
}
```

**Integration**: Could standardize JARVIS-FRESH dev environment setup.

---

## Server Monitoring

### Nezha

**Architecture**: Central dashboard + lightweight agents on monitored servers.

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Server 1   │     │   Server 2   │     │   Server N   │
│  ┌────────┐  │     │  ┌────────┐  │     │  ┌────────┐  │
│  │ Agent  │──┼─────┼──│ Agent  │──┼─────┼──│ Agent  │  │
│  └────────┘  │     │  └────────┘  │     │  └────────┘  │
└──────────────┘     └──────────────┘     └──────────────┘
        │                    │                    │
        └────────────────────┼────────────────────┘
                             │
                    ┌────────▼────────┐
                    │  Nezha Dashboard │
                    │   (Docker)       │
                    └─────────────────┘
```

**Metrics**: CPU, memory, disk, network, uptime, latency, SSL expiry.

**Deploy**:
```bash
docker run -d --name nezha -p 8008:80 -p 5555:5555 ghcr.io/naiba/nezha-dashboard
```

---

## Distributed Task Queues

### Hatchet

**Value**: DAG-based task orchestration with built-in retries, timeouts, and concurrency control.

**vs Celery**: Better visibility, DAG support, built-in dashboard, no Redis/RabbitMQ requirement.

**Concepts**:
- **Workflows**: Define multi-step DAGs with dependencies
- **Workers**: Process steps with configurable concurrency
- **Events**: Trigger workflows from external events
- **Retries**: Configurable retry policies per step

```python
# Hatchet workflow definition (Python SDK)
from hatchet_sdk import Hatchet

hatchet = Hatchet()

@hatchet.workflow(on_events=["user:created"])
class OnboardingWorkflow:
    @hatchet.step()
    def send_welcome_email(self, context):
        user = context.workflow_input()
        # Send email
        return {"email_sent": True}

    @hatchet.step(parents=["send_welcome_email"])
    def create_default_workspace(self, context):
        # Create workspace
        return {"workspace_created": True}
```

**Integration**: Could replace/supplement JARVIS task queue for long-running operations.

---

## Data Anonymization

### Neosync

**Value**: Generate synthetic data or anonymize production data for development/testing.

**Key Features**:
- **Synthetic data generation**: Create realistic fake data matching schema
- **Data anonymization**: Mask PII in production database copies
- **Referential integrity**: Maintains foreign key relationships
- **Transformers**: Built-in transformers for names, emails, addresses, SSNs

**Deploy**:
```bash
docker compose -f neosync/docker-compose.yml up -d
```

**Integration**: JARVIS test data generation, GDPR/CCPA compliance for dev databases.

---

## Automation Platforms

### ByteChef

**Value**: Open-source alternative to Zapier/Make for workflow automation.

**Key Features**:
- Visual workflow builder
- 50+ integrations (Google, Slack, GitHub, databases)
- Webhook triggers
- Custom code steps (JavaScript)
- Self-hosted with Docker

**vs n8n**: More enterprise-focused, better error handling, built-in data transformation.

---

## IoT & MQTT

### MQTTX

**Value**: Cross-platform MQTT 5.0 client for IoT development and testing.

**Features**:
- Desktop app + CLI + web interface
- MQTT 3.1/3.1.1/5.0 support
- WebSocket support
- Message scripting
- Benchmark testing

**CLI**:
```bash
# Subscribe to topic
mqttx sub -t 'sensors/#' -h broker.example.com

# Publish message
mqttx pub -t 'sensors/temp' -m '{"value": 23.5}' -h broker.example.com

# Benchmark
mqttx bench pub -t 'test' -c 1000 -m '{"test":true}' -h localhost
```

---

## IT Asset Management

### GLPI

**Value**: Complete IT asset management + help desk in one platform.

**Features**:
- Hardware/software inventory
- Ticketing system
- License management
- Knowledge base
- Network discovery
- LDAP/AD integration

**Deploy**:
```bash
docker run -d --name glpi -p 80:80 diouxx/glpi
```

---

## Integration with Khaled's Environment

| Tool | Khaled's Integration Point |
|------|---------------------------|
| Tauri | `jarvis-desktop` modernization |
| Devbox | JARVIS-FRESH dev environment standardization |
| Nezha | Server monitoring for deployed JARVIS instances |
| Hatchet | JARVIS distributed task execution |
| Neosync | Test data generation, GDPR compliance |
| ByteChef | JARVIS workflow automation connectors |
| MQTTX | IoT data pipeline testing |
| GLPI | IT asset tracking for infrastructure |

### Deployment via Docker MCP
All self-hosted tools can be deployed via Khaled's Docker MCP server:
```
mcp__MCP_DOCKER__mcp-exec → Run containers
mcp__MCP_DOCKER__mcp-find → Find running services
```

---

## Cross-References

- **devops-patterns** skill: Terraform, K8s, Docker, CI/CD patterns
- **infra-engineer** agent: Infrastructure automation
- **docker-specialist** agent: Container optimization
- **devops-architect** agent: Infrastructure design
- **Docker** MCP: Container management (6 tools)
