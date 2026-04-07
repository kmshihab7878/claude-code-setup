# Autoresearch Loop

Launch an autonomous self-improvement loop on a target file.

## Instructions

You are executing the **autoresearch loop** — an autonomous, iterative optimization process adapted from Karpathy's autoresearch methodology.

**User input**: `$ARGUMENTS`

Parse the input for:
- **Target file**: The file to modify (e.g., `strategy.py`, `config.yaml`, source file)
- **Eval command**: The command to run for evaluation (e.g., `uv run backtest.py`, `pytest`)
- **Score pattern**: How to extract the score from output (e.g., `score:`, `passed`, custom regex)

If any of these are missing, ask the user to provide them.

## Setup Phase

1. **Verify target exists**: Read the target file to understand its current state
2. **Create experiment branch**: `git checkout -b autoresearch/<date-tag>` (never work on main)
3. **Run baseline**: Execute the eval command, extract the initial score
4. **Initialize tracking**:
   - Create `results.tsv` with headers: `experiment	score	delta	status	hypothesis`
   - Record baseline as `exp0`
5. **Announce**: Report baseline score and confirm loop is starting

## Loop Phase

Execute this loop autonomously. Do NOT pause to ask the user between iterations.

For each experiment (exp1, exp2, exp3, ...):

### 1. Analyze
- Read current state of target file
- Review results.tsv for what has been tried
- Identify the most promising modification (prioritize Tier 1 ideas first)

### 2. Hypothesize
- State a clear, testable hypothesis: "If I [change], then [expected effect] because [reasoning]"

### 3. Implement
- Make ONE focused change to the target file
- Commit: `git commit -am "exp<N>: <hypothesis summary>"`

### 4. Test
- Run the eval command
- Extract the score using the score pattern

### 5. Decide
- **Score improved**: KEEP the commit, update best score, log as KEEP
- **Score equal or worse**: REVERT with `git reset --hard HEAD~1`, log as DISCARD
- **Crashed/errored**: REVERT, log as ERROR, analyze the error and try a different approach

### 6. Log
- Append result to results.tsv
- Continue to next experiment immediately

## Research Priorities

### Tier 1 — High probability
- Parameter tuning within known-good ranges
- Simplification (remove features that don't contribute)
- Well-established patterns from the domain

### Tier 2 — Worth exploring
- New approaches with theoretical backing
- Cross-domain adaptation of proven techniques
- Ensemble/combination strategies

### Tier 3 — Novel
- Fundamentally different approaches
- Complex interactions
- Speculative hypotheses

## Simplification Pass

After every 15 experiments, run a "simplification pass":
- Systematically remove features one at a time
- Test if the score improves without each feature
- Complexity removal often produces larger gains than feature addition

## When to Stop

- User interrupts (Ctrl+C or message)
- 50+ consecutive experiments without improvement (plateau detected)
- Score reaches theoretical maximum
- All Tier 1 and Tier 2 ideas exhausted

## Output

After stopping, report:
1. **Best score achieved** and which experiment
2. **Score progression**: baseline → best (improvement factor)
3. **Key learnings**: What worked, what didn't, patterns observed
4. **Top 3 recommendations** for further improvement
