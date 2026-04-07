# Curated Tools Reference

> Miscellaneous tools evaluated for Khaled's environment
> Compiled: 2026-03-15

---

## macOS System Monitoring

### Stats (exelban)
**What**: Lightweight macOS system monitor — lives in the menu bar.

**Monitors**: CPU, GPU, memory, disk, network, battery, Bluetooth, sensors (temperature/fan).

**Why Notable**: Native Swift app, minimal resource usage (~20MB RAM), replaces Activity Monitor for at-a-glance monitoring. Open source (MIT).

**Install**: `brew install --cask stats`

**Integration**: Useful for monitoring system resources during heavy Claude Code sessions or LLM inference with Ollama.

---

## Terminal Tools

### termscp — Terminal File Transfer
**What**: TUI-based file transfer client supporting SCP, SFTP, FTP, S3, SMB, WebDAV, and more.

**Key Features**:
- Dual-pane file browser (like Midnight Commander)
- Bookmarks for frequent connections
- Text editor integration
- SSH key support
- Recursive transfer

**Install**: `brew install termscp` or `cargo install termscp`

**When to Use**: Transferring files to/from remote servers when you want a visual interface instead of raw `scp` commands.

### sampler — Terminal Dashboard
**What**: Configurable terminal dashboard for real-time metric visualization.

**Key Features**:
- YAML configuration
- Run any shell command and visualize output
- Charts: sparkline, bar, gauge, text, ASCII graph
- Triggers and alerts
- Multiple data sources in one view

**Config Example**:
```yaml
sparklines:
  - title: CPU Usage
    rate-ms: 500
    sample: top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d '%'
  - title: Memory Pressure
    rate-ms: 1000
    sample: memory_pressure | head -1 | awk '{print $4}'

barcharts:
  - title: Docker Containers
    rate-ms: 5000
    items:
      - label: Running
        sample: docker ps -q | wc -l | tr -d ' '
      - label: Stopped
        sample: docker ps -aq --filter status=exited | wc -l | tr -d ' '
```

**Install**: `brew install sampler`

---

## Data & Content Tools

### Label Studio — Data Labeling
**What**: Open-source data labeling platform for ML pipelines.

**Annotation Types**: Text classification, NER, image segmentation, object detection, audio transcription, video annotation, time series.

**Key Features**:
- Web-based annotation UI
- ML-assisted labeling (pre-annotate with model predictions)
- Multi-user with reviewer workflow
- Export to common formats (COCO, VOC, YOLO, CoNLL)
- API for integration with ML pipelines

**Deploy**: `docker run -p 8080:8080 heartexlabs/label-studio`

**Integration**: Useful for creating training data for JARVIS ML models or fine-tuning experiments.

### Handsontable — Spreadsheet Component
**What**: JavaScript spreadsheet component with Excel-like experience.

**Key Features**:
- React, Vue, Angular wrappers
- 400+ cell types and validators
- Copy/paste from Excel
- Undo/redo, sorting, filtering
- Formula support
- Custom cell renderers

**Comparison with xlsx skill**: xlsx skill handles file I/O (read/write .xlsx files). Handsontable provides a web-based spreadsheet UI component for displaying/editing data in the browser.

**When to Use**: Building dashboards or admin panels that need inline data editing.

### Enchanted — macOS LLM Chat Client
**What**: Native macOS app for chatting with local LLMs via Ollama.

**Key Features**:
- Native SwiftUI interface
- Ollama integration (auto-discovers models)
- Conversation history
- Markdown rendering
- Image input for vision models
- Voice input

**Integration**: Complements Khaled's Ollama setup with a polished GUI client. Alternative to terminal-based Ollama interactions.

**Install**: Download from GitHub releases or `brew install --cask enchanted`

---

## Documentation

### Docusaurus — Docs Framework
**What**: Facebook's documentation website framework.

**Key Features**:
- React-based static site generator
- Versioned documentation
- Built-in search (Algolia integration)
- MDX support (React in Markdown)
- i18n (internationalization)
- Blog support
- Plugin ecosystem

**When to Use**: Creating documentation sites for projects. Could be useful for JARVIS documentation portal.

**Quick Start**:
```bash
npx create-docusaurus@latest my-docs classic
cd my-docs && npm start
```

---

## AI Tools

### DeepCode (HKUDS)
**What**: Research project on AI-powered code generation.

**Key Concepts**:
- Hierarchical code generation (plan → scaffold → implement)
- Code-aware context selection
- Multi-turn code refinement

**Pattern to Extract**: Hierarchical generation — break code generation into planning and implementation phases. Already partially implemented in JARVIS Planner.

### CoAI — AI Chat Platform
**What**: Open-source AI chat platform supporting multiple models.

**Key Features**:
- Multi-model support (OpenAI, Anthropic, Ollama, etc.)
- API key management
- Conversation sharing
- Plugin system
- Self-hosted

**Deploy**: `docker compose up -d`

### ART — AI Testing (OpenPipe)
**What**: Automated testing framework for AI/LLM outputs.

**Key Concepts**:
- Define test cases with expected behaviors
- Run evaluations across model versions
- Track regression/improvement over time
- Statistical analysis of LLM quality

**Pattern to Extract**: Systematic LLM output testing — useful for JARVIS agent quality validation.

---

## File Storage

### Hoodik — Self-hosted Storage
**What**: Encrypted file storage with sharing capabilities.

**Key Features**:
- Client-side encryption (zero-knowledge)
- File sharing with expiring links
- Web upload interface
- API access
- Docker deployment

**Deploy**: Docker compose (Rust backend, React frontend)

**Integration**: Could serve as secure file storage for sensitive JARVIS documents.

---

## Integration Map

| Tool | Integration Point |
|------|-------------------|
| Stats | Monitor system during heavy workloads |
| termscp | Transfer files to/from JARVIS servers |
| sampler | Custom terminal dashboard for JARVIS metrics |
| Label Studio | Training data for JARVIS ML models (Docker MCP) |
| Handsontable | JARVIS frontend spreadsheet components |
| Enchanted | GUI for local Ollama interactions |
| Docusaurus | JARVIS documentation site |
| CoAI | Multi-model chat alternative |
| ART | JARVIS agent testing framework |
| Hoodik | Encrypted document storage (Docker MCP) |

---

## Cross-References

- **pdf** skill + `OCR_AND_CONVERSION.md`: EasyOCR patterns
- **xlsx** skill: Spreadsheet file I/O
- **Docker** MCP: Deploy self-hosted tools
- **devops-patterns** skill: Container deployment
- **webapp-testing** skill: Browser-based tool testing
