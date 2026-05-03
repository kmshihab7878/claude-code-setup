# Code Review

Perform a comprehensive 6-aspect code review on the specified files or recent changes.

## Instructions

1. Identify the target: Use `$ARGUMENTS` if provided, otherwise review staged/unstaged git changes
2. Read all relevant files thoroughly
3. Analyze across 6 dimensions using the `code-reviewer` agent methodology:
   - **Correctness**: Logic errors, edge cases, type safety
   - **Security**: Injection, auth gaps, secrets exposure
   - **Performance**: N+1 queries, memory leaks, algorithmic complexity
   - **Readability**: Naming, structure, conventions
   - **Error Handling**: Missing catches, propagation, user messages
   - **Test Coverage**: Are changes tested? Edge cases covered?
4. Rate each finding: CRITICAL / HIGH / MEDIUM / LOW
5. Provide specific fix suggestions with code examples
6. Give final verdict: APPROVE / REQUEST CHANGES / NEEDS DISCUSSION

Output the review in structured markdown format with file:line references.

### Knowledge Graph Impact Analysis

Before reviewing, check if `.understand-anything/knowledge-graph.json` exists in the project directory. If it does:

1. **Run diff impact analysis**: Get the changed files from the diff, then map them to knowledge graph nodes
2. **Identify affected components**: For each changed file, find 1-hop neighbors in the graph (files that import from or are imported by the changed files)
3. **Cross-layer impact**: Check if changes cross architectural layer boundaries (e.g., a core change that affects API + agents)
4. **Add to review output**:
   ```
   ## Impact Analysis (from Knowledge Graph)
   - Changed nodes: {list}
   - Directly affected: {list of 1-hop neighbors}
   - Layers impacted: {list}
   - Risk level: LOW/MEDIUM/HIGH (based on cross-layer impact + number of affected nodes)
   ```

This analysis uses the `/understand-diff` skill under the hood. If no knowledge graph exists, skip this section.

### Karpathy Review (Behavioral Governor)

For non-trivial diffs, run `skills/karpathy-review/SKILL.md` after the 6-aspect review. It checks the diff against four behavioral principles that catch issues the technical review can miss:

1. **Think Before Coding** — were assumptions stated? Was ambiguity resolved or silently chosen?
2. **Simplicity First** — is this the smallest solution, or did it grow speculative abstractions?
3. **Surgical Changes** — does every changed line trace to the user's request? Any drive-by edits?
4. **Goal-Driven Execution** — was a success criterion stated and verified?

Skip this for trivial diffs (typos, whitespace, one-line docs). The skill returns "out of scope, skip" for those cases — that's a valid result.

Output: a 4-section terse report with verdict PROCEED / SIMPLIFY / ASK / STOP. See `references/karpathy-principles.md` for the full reasoning behind each principle.

### SHA-Based Review Requesting (KhaledPowers)

When requesting a review from a subagent or another session:

1. **Identify the commit range**: `git log --oneline <base>..HEAD`
2. **Generate the diff**: `git diff <base-sha>..HEAD`
3. **Include in the review request**:
   - Base SHA and HEAD SHA
   - Summary of what changed and why
   - Specific areas of concern (if any)
   - The acceptance criteria the code should meet
4. **Reviewer uses the SHAs** to check out and verify independently
