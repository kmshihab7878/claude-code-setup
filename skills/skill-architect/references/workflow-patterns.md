# Skill Workflow Patterns

Five reusable patterns for structuring Claude Code skill logic. Each pattern includes a description, when to use it, a template, an existing skill example, and an anti-pattern to avoid.

## 1. Sequential Orchestration

**Description**: Steps executed in fixed order, each depending on the previous step's output. Linear and predictable.

**When to use**: Pre-flight checks, deployment pipelines, review workflows, any process with mandatory ordering.

**Template**:
```
## workflow
1. **Gather** — read relevant files, check prerequisites
2. **Analyze** — evaluate against criteria
3. **Act** — make changes or produce output
4. **Verify** — confirm the result meets criteria
```

**Example**: `coding-workflow` — pre-implementation checklist runs in order: understand requirement, read code, identify files, check patterns, verify no duplicates.

**Anti-pattern**: Skipping steps based on assumptions. If step 2 depends on step 1, never allow bypassing step 1 even if the answer "seems obvious."

## 2. Multi-Tool Coordination

**Description**: Orchestrates multiple tools or MCP servers to accomplish a single goal. Routes sub-tasks to the right tool.

**When to use**: Skills that need data from multiple sources, skills wrapping MCP servers, skills that combine search + edit + validate.

**Template**:
```
## tools used
| Tool | Purpose |
|------|---------|
| Grep | Find relevant code |
| Read | Load file contents |
| Edit | Apply changes |
| Bash | Run validation |

## workflow
1. Use **Grep** to locate targets
2. Use **Read** to understand context
3. Use **Edit** to apply changes
4. Use **Bash** to validate result
```

**Example**: `aster-trading` — coordinates MCP tools (get_ticker, get_balance, create_order) in specific sequences for trading workflows.

**Anti-pattern**: Using one tool for everything. Don't use Bash to read files when Read exists. Don't use Grep to edit when Edit exists. Match tool to purpose.

## 3. Iterative Refinement

**Description**: Produces an initial result, evaluates it against criteria, and loops until quality thresholds are met. Converges toward a target.

**When to use**: Code generation, text editing, optimization tasks, any process where first output is rarely final.

**Template**:
```
## workflow
1. **Generate** initial output
2. **Evaluate** against quality criteria
3. **If criteria not met**: identify specific gaps, refine, go to step 2
4. **If criteria met**: finalize and present
```

**Example**: `confidence-check` — scores confidence across 5 dimensions; if below 90%, identifies gaps and requests more information before proceeding.

**Anti-pattern**: Infinite loops with no exit condition. Always define a maximum iteration count (typically 3) and a clear "good enough" threshold.

## 4. Context-Aware Selection

**Description**: Examines the current context (selection, project type, file patterns) and branches to the appropriate sub-workflow. Adaptive routing.

**When to use**: Skills that handle multiple scenarios, skills that adapt behavior based on project conventions, multi-language support.

**Template**:
```
## decision logic
| Context Signal | Action |
|---------------|--------|
| TypeScript project | Apply TS conventions |
| Python project | Apply Python conventions |
| Unknown project | Ask user to clarify |

## workflow
1. **Detect** context (read config files, check file extensions)
2. **Select** appropriate sub-workflow
3. **Execute** selected workflow
4. **Validate** output matches context expectations
```

**Example**: `ui-ux-pro-max` — detects the frontend stack (React, Vue, Svelte, etc.) and adapts design system output accordingly.

**Anti-pattern**: Hardcoding assumptions. Don't assume "all projects use TypeScript" — always detect and confirm.

## 5. Domain-Specific Intelligence

**Description**: Embeds deep domain knowledge (rules, constraints, best practices) as structured reference data. Applies domain rules during execution.

**When to use**: Specialized domains (trading, security, accessibility), compliance-heavy workflows, skills where domain mistakes are costly.

**Template**:
```
## domain rules
### critical (must follow)
- Rule 1: [mandatory constraint]
- Rule 2: [mandatory constraint]

### recommended (should follow)
- Rule 3: [best practice]

## reference data
| Concept | Details |
|---------|---------|
| Term A | Definition and usage |
| Term B | Definition and usage |

## workflow
1. Load applicable domain rules
2. Execute task within rule constraints
3. Validate output against all critical rules
4. Flag any recommended rule violations as warnings
```

**Example**: `aster-trading` — embeds risk rules (user confirmation required, leverage warnings, position size disclosure) as mandatory constraints that gate every trading action.

**Anti-pattern**: Soft-pedaling critical rules. If a domain rule is mandatory (e.g., "never execute trades without confirmation"), use MUST/NEVER language, not "try to" or "consider."
