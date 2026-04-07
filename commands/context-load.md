# Context Load

Load and analyze project context for effective assistance.

## Instructions

Use `$ARGUMENTS` to specify a project path or focus area. Default: current working directory.

### Step 1: Project Structure
- Scan directory structure (top 3 levels)
- Identify project type (Python, Node, monorepo, etc.)
- Find configuration files (package.json, pyproject.toml, Cargo.toml, etc.)
- Detect frameworks in use

### Step 2: Tech Stack
- Language(s) and versions
- Frameworks and key libraries
- Database(s) and ORM
- Build tools and bundlers
- Testing frameworks
- CI/CD platform

### Step 3: Architecture
- Entry points (main files, API routes)
- Core modules and their responsibilities
- Data models / schema
- External service integrations

### Step 4: Conventions
- Code style (linter config, formatting)
- Git workflow (branch naming, commit conventions)
- Testing patterns
- Error handling patterns
- Naming conventions

### Step 5: Key Files
- README, CONTRIBUTING, CLAUDE.md
- Environment configuration
- Docker/deployment configs
- Migration files

### Step 6: Knowledge Graph (if available)
- Check if `.understand-anything/knowledge-graph.json` exists in the project directory
- If found, read and extract:
  - **Graph stats**: total nodes, edges, layers
  - **Module map**: list all module nodes and their descriptions
  - **Architecture layers**: list layers with node counts
  - **Key components**: top 10 most-connected nodes (highest edge count)
  - **Tour overview**: list tour step titles for quick orientation
  - **Last analyzed**: timestamp and commit hash from meta.json
- If the graph is stale (commit hash differs from current HEAD), note this and suggest running `/understand` to update
- Also check Memory MCP for synced entities: `mcp__memory__search_nodes("{project-name}")` — if found, include cross-session context

Output a structured context summary that can be referenced throughout the session. When a knowledge graph is available, lead with the architecture overview from the graph before diving into file-level details.
