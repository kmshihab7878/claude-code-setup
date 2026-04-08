# Claude Code Ecosystem Reference

> Tools, templates, and extensions that enhance Claude Code
> Compiled: 2026-03-15

---

## Ecosystem Overview

| Tool | Category | Status | Integration Value |
|------|----------|--------|-------------------|
| claude-code-templates | Templates | Evaluate | High — reusable project scaffolds |
| zcf (Zero Config Framework) | CLI Enhancer | Evaluate | Medium — workflow shortcuts |
| awesome-claude-code | Curated List | Reference | High — ecosystem awareness |
| claudia | Agent Framework | Evaluate | Medium — alternative agent patterns |
| serena | Code Intelligence MCP | Evaluate | High — LSP-powered code analysis |

---

## Tool Deep Dives

### 1. claude-code-templates (davila7)

**Repository**: `github.com/davila7/claude-code-templates`

**What it is**: Collection of reusable templates for Claude Code projects — CLAUDE.md templates, agent definitions, skill scaffolds, and project configurations.

**Key Features**:
- Pre-built CLAUDE.md templates for different project types
- Agent definition templates with best practices
- Skill scaffolds with proper YAML frontmatter
- MCP server configuration templates
- Hook configuration examples

**Integration with Khaled's Setup**:
- Compare template patterns with existing 40 agents for improvement ideas
- Evaluate CLAUDE.md template against existing global CLAUDE.md
- Check for skill patterns not yet in the 34-skill inventory

**Installation**:
```bash
cd ~/Projects
gh repo clone davila7/claude-code-templates
# Review templates, cherry-pick useful patterns
```

### 2. zcf — Zero Config Framework (UfoMiao)

**Repository**: `github.com/UfoMiao/zcf`

**What it is**: CLI tool that provides zero-config scaffolding and workflow shortcuts for Claude Code projects.

**Key Features**:
- Project initialization with sensible defaults
- Automated CLAUDE.md generation based on project detection
- Workflow shortcuts for common Claude Code patterns
- Template management system

**Integration Assessment**:
- Khaled already has extensive custom CLAUDE.md — zcf generation may conflict
- Workflow shortcuts could complement existing 56 commands
- Template management could help organize 34 skills

**Installation** (if viable):
```bash
cd ~/Projects
gh repo clone UfoMiao/zcf
# Review compatibility with existing setup before installing
```

### 3. awesome-claude-code (hesreallyhim)

**Repository**: `github.com/hesreallyhim/awesome-claude-code`

**What it is**: Curated list of Claude Code resources — MCP servers, skills, agents, templates, tips, and community tools.

**Categories Typically Covered**:
- MCP servers beyond the standard set
- Community-built skills and agents
- Prompt engineering patterns for Claude Code
- Integration guides with IDEs and tools
- Performance tips and best practices

**Gap Analysis Against Khaled's Setup**:

| Category | Khaled Has | Potential Gaps |
|----------|-----------|----------------|
| MCP Servers | 8 (penpot, memory, filesystem, sequential, github, context7, docker, aster) | Code intelligence, database, email, calendar |
| Skills | 34 | Potentially missing: code-review-ai, deployment, monitoring |
| Agents | 40 | Coverage seems comprehensive |
| Hooks | 3 | Could add: pre-commit code quality, auto-formatting |

### 4. claudia (getAsterisk)

**Repository**: `github.com/getAsterisk/claudia`

**What it is**: Agent framework that extends Claude Code with enhanced agent management capabilities.

**Key Features**:
- Agent lifecycle management
- Inter-agent communication protocols
- Agent state persistence
- Performance monitoring for agents

**Integration Assessment**:
- Khaled's SuperClaude + BMAD already provide 40 agents
- Could offer patterns for agent monitoring not currently implemented
- Evaluate for agent health dashboard concepts

### 5. serena (oraios)

**Repository**: `github.com/oraios/serena`

**What it is**: MCP server that provides code intelligence via Language Server Protocol (LSP) integration. Gives Claude Code deep understanding of code structure, symbols, references, and definitions.

**Key Features**:
- Go-to-definition across files
- Find all references for symbols
- Code navigation via LSP
- Symbol search across project
- Type information and hover documentation
- Diagnostic information (errors, warnings)

**Integration Assessment**:
- **High value**: Would give Claude Code semantic code understanding
- **Complementary**: Works alongside existing Pyright LSP plugin in `~/.claude/plugins/`
- **Multi-language**: Supports any language with an LSP server
- **MCP Server #9**: Would fit into Khaled's MCP server collection

**Potential Installation**:
```bash
cd ~/Projects
gh repo clone oraios/serena
cd serena && npm install
# Add to ~/.claude.json as MCP server
```

**Configuration Pattern**:
```json
{
  "mcpServers": {
    "serena": {
      "type": "stdio",
      "command": "node",
      "args": ["~/Projects/serena/dist/index.js"],
      "env": {
        "PROJECT_ROOT": "~/your-project"
      }
    }
  }
}
```

---

## Recommended Actions

### Immediate (High Impact)
1. **Evaluate serena** for code intelligence MCP server
2. **Review awesome-claude-code** for missing MCP servers and skills
3. **Clone claude-code-templates** to compare patterns

### Future Consideration
4. **Evaluate zcf** for workflow shortcuts
5. **Review claudia** for agent monitoring patterns

---

## Community Patterns Worth Adopting

### CLAUDE.md Best Practices (from ecosystem)
- **Project-specific overrides**: Use per-project CLAUDE.md for project-specific rules
- **Skill auto-detection**: Reference skills by trigger patterns, not manual invocation
- **Agent specialization**: Each agent should have a clear, non-overlapping domain
- **Hook composition**: Chain hooks for multi-step validation

### MCP Server Selection Criteria
When evaluating new MCP servers:
1. **Gap analysis**: Does it fill a capability Khaled doesn't have?
2. **Security**: Does it follow localhost isolation (Rule 26)?
3. **Stability**: Is the project actively maintained?
4. **Transport**: stdio preferred over HTTP for security
5. **Overlap**: Does it duplicate an existing server's capabilities?

---

## Cross-References

- **CLAUDE_CODE_ARCHITECTURE.md**: Full architecture overview (8 MCP, 40 agents, 34 skills)
- **SECURITY_PLAYBOOK.md** Rules 26-29: MCP server trust policies
- **mcp-builder** skill: Build custom MCP servers
- **skill-creator** skill: Create and benchmark skills
