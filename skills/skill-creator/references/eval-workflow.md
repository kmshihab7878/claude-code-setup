# Eval-and-review workflow (full procedure)

The five-step sequence for running test cases, grading, aggregating, viewing, and reading feedback. SKILL.md keeps the high-level loop; this file holds the per-step detail. Do **not** stop partway through the sequence. Do **not** use `/skill-test` or any other testing skill — this is the canonical path.

Put results in `<skill-name>-workspace/` as a sibling to the skill. Within, organize by iteration (`iteration-1/`, etc.); each test case gets a directory (`eval-0/`, etc.). Create as you go.

## Step 1: Spawn all runs (with-skill AND baseline) in the same turn

For each test case, spawn two subagents in one turn — one with the skill, one without. Don't sequence them. Launch everything at once.

**With-skill run:**

```
Execute this task:
- Skill path: <path-to-skill>
- Task: <eval prompt>
- Input files: <eval files if any, or "none">
- Save outputs to: <workspace>/iteration-<N>/eval-<ID>/with_skill/outputs/
- Outputs to save: <what the user cares about — e.g., "the .docx file", "the final CSV">
```

**Baseline run** — same prompt; baseline depends on context:
- **Creating a new skill:** no skill at all. Save to `without_skill/outputs/`.
- **Improving an existing skill:** the old version. Snapshot first (`cp -r <skill-path> <workspace>/skill-snapshot/`), then point the baseline subagent at the snapshot. Save to `old_skill/outputs/`.

Write `eval_metadata.json` per test case (assertions can be empty for now). Give each eval a descriptive name based on what it's testing — not just "eval-0". Use this name for the directory. If this iteration uses new or modified eval prompts, create the files for each new directory — don't assume carryover.

```json
{
  "eval_id": 0,
  "eval_name": "descriptive-name-here",
  "prompt": "The user's task prompt",
  "assertions": []
}
```

## Step 2: While runs are in progress, draft assertions

Use the time productively. Draft quantitative assertions for each test case and explain them. If assertions already exist in `evals/evals.json`, review and explain.

Good assertions are objectively verifiable with descriptive names — they read clearly in the benchmark viewer. Subjective skills (writing style, design quality) get qualitative evaluation — don't force assertions onto things needing human judgment.

Update `eval_metadata.json` and `evals/evals.json` with assertions. Explain to the user what they'll see in the viewer.

## Step 3: As runs complete, capture timing data

Each subagent completion notification contains `total_tokens` and `duration_ms`. Save immediately to `timing.json` in the run directory:

```json
{
  "total_tokens": 84852,
  "duration_ms": 23332,
  "total_duration_seconds": 23.3
}
```

This is the only opportunity — the data comes through the notification and isn't persisted elsewhere. Process notifications as they arrive.

## Step 4: Grade, aggregate, and launch the viewer

Once all runs are done:

1. **Grade each run** — spawn a grader subagent (or grade inline) reading `agents/grader.md`. Save results to `grading.json` in each run directory. The `grading.json` expectations array must use fields `text`, `passed`, `evidence` (not `name`/`met`/`details`) — the viewer depends on these names. For programmatically checkable assertions, write and run a script.

2. **Aggregate into benchmark** — from the skill-creator directory:
   ```bash
   python -m scripts.aggregate_benchmark <workspace>/iteration-N --skill-name <name>
   ```
   Produces `benchmark.json` + `benchmark.md` with pass_rate, time, tokens per configuration, mean ± stddev, and the delta. For manual generation see `references/schemas.md`. Put each `with_skill` version before its baseline counterpart.

3. **Analyst pass** — read benchmark data and surface patterns aggregates hide. See `agents/analyzer.md` ("Analyzing Benchmark Results"): non-discriminating assertions, high-variance evals, time/token tradeoffs.

4. **Launch the viewer** with qualitative + quantitative data:
   ```bash
   nohup python <skill-creator-path>/eval-viewer/generate_review.py \
     <workspace>/iteration-N \
     --skill-name "my-skill" \
     --benchmark <workspace>/iteration-N/benchmark.json \
     > /dev/null 2>&1 &
   VIEWER_PID=$!
   ```
   Iteration 2+: also pass `--previous-workspace <workspace>/iteration-<N-1>`.

   **Cowork / headless:** if `webbrowser.open()` is unavailable or no display, use `--static <output_path>` to write standalone HTML. Feedback downloads as `feedback.json` when the user clicks "Submit All Reviews". Copy `feedback.json` into the workspace for the next iteration.

Use `generate_review.py` — don't write custom HTML.

5. **Tell the user:** "I've opened the results in your browser. Two tabs — 'Outputs' to click through each test case and leave feedback; 'Benchmark' for the quantitative comparison. Come back here when done."

### What the user sees in the viewer

The "Outputs" tab shows one test case at a time:
- **Prompt** — the task.
- **Output** — files the skill produced, rendered inline where possible.
- **Previous Output** (iteration 2+): collapsed section showing last iteration's output.
- **Formal Grades** (if graded): collapsed section with assertion pass/fail.
- **Feedback** — auto-saving textbox.
- **Previous Feedback** (iteration 2+): their comments from last time.

The "Benchmark" tab shows pass rates, timing, token usage per configuration, per-eval breakdowns, and analyst observations.

Navigation: prev/next or arrow keys. "Submit All Reviews" saves feedback to `feedback.json`.

## Step 5: Read the feedback

When done, read `feedback.json`:

```json
{
  "reviews": [
    {"run_id": "eval-0-with_skill", "feedback": "the chart is missing axis labels", "timestamp": "..."},
    {"run_id": "eval-1-with_skill", "feedback": "", "timestamp": "..."},
    {"run_id": "eval-2-with_skill", "feedback": "perfect, love this", "timestamp": "..."}
  ],
  "status": "complete"
}
```

Empty feedback = fine. Focus improvements on test cases with specific complaints.

Kill the viewer when done:

```bash
kill $VIEWER_PID 2>/dev/null
```
