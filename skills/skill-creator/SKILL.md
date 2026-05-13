---
name: skill-creator
description: Create new skills, modify and improve existing skills, and measure skill performance. Use when users want to create a skill from scratch, edit, or optimize an existing skill, run evals to test a skill, benchmark skill performance with variance analysis, or optimize a skill's description for better triggering accuracy.
---

# Skill Creator

For creating new skills and iteratively improving them.

## High-level loop

- Decide what the skill should do.
- Write a draft.
- Create a few test prompts and run claude-with-access-to-the-skill on them.
- Help the user evaluate qualitatively and quantitatively (use `eval-viewer/generate_review.py` for review; benchmark via assertions for quantitative).
- Rewrite based on feedback and benchmarks.
- Repeat until satisfied. Expand the test set and try again at larger scale.

Figure out where the user is in this process and jump in. If they say "I want a skill for X" — narrow the intent, draft, write tests, evaluate, iterate. If they already have a draft, go straight to eval/iterate. If they say "just vibe with me", skip evals.

After the skill is done, optionally run the description optimizer to improve triggering.

## Communicating with the user

Users span a wide range of coding familiarity. Pay attention to context cues:
- "evaluation" and "benchmark" are borderline OK.
- For "JSON" and "assertion", look for cues the user knows them before using without explanation.

Explain terms briefly when in doubt.

---

## Creating a skill

### Capture intent

Start by understanding the user's intent. The conversation may already contain a workflow to capture (e.g., "turn this into a skill") — extract from history first: tools used, sequence, corrections, input/output formats. User fills gaps and confirms before next step.

1. What should this skill enable Claude to do?
2. When should this skill trigger? (user phrases/contexts)
3. What's the expected output format?
4. Should we set up test cases? Skills with objectively verifiable outputs (file transforms, data extraction, code generation, fixed workflows) benefit from tests. Subjective outputs (writing, art) often don't. Suggest the default; let the user decide.

### Interview and research

Proactively ask about edge cases, input/output formats, example files, success criteria, dependencies. Don't write test prompts until this is ironed out.

Check available MCPs. If useful for research, research in parallel via subagents (or inline). Come prepared.

### Write the SKILL.md

Based on the interview, fill in:
- **name**: skill identifier.
- **description**: when to trigger + what it does. This is the primary triggering mechanism — include both. All "when to use" lives here, not in the body. Claude tends to **undertrigger** skills, so make descriptions slightly "pushy". Instead of "How to build a simple dashboard for internal data", write "How to build a simple dashboard for internal data. Use this skill whenever the user mentions dashboards, data visualization, internal metrics, or wants to display any kind of company data, even if they don't explicitly ask for a 'dashboard.'"
- **compatibility**: required tools, dependencies (rarely needed).
- The rest of the skill.

### Skill writing guide

#### Anatomy

```
skill-name/
├── SKILL.md (required)
│   ├── YAML frontmatter (name, description required)
│   └── Markdown instructions
└── Bundled Resources (optional)
    ├── scripts/    - Executable code for deterministic/repetitive tasks
    ├── references/ - Docs loaded into context as needed
    └── assets/     - Files used in output (templates, icons, fonts)
```

#### Progressive disclosure

Three-level loading:
1. **Metadata** (name + description) — always in context (~100 words).
2. **SKILL.md body** — in context whenever skill triggers (<500 lines ideal).
3. **Bundled resources** — as needed (unlimited; scripts execute without loading).

Word counts are approximate; go longer if needed.

**Key patterns:**
- Keep SKILL.md under 500 lines; if approaching this limit, add hierarchy + pointers to follow-up files.
- Reference files clearly from SKILL.md with guidance on when to read them.
- Large reference files (>300 lines) need a table of contents.

**Domain organization** — for skills supporting multiple frameworks, organize by variant:

```
cloud-deploy/
├── SKILL.md (workflow + selection)
└── references/
    ├── aws.md
    ├── gcp.md
    └── azure.md
```

Claude reads only the relevant reference.

#### Principle of lack of surprise

Skills must not contain malware, exploit code, or content that compromises system security. A skill's contents must not surprise the user given the description. Don't create misleading skills or facilitate unauthorized access / data exfiltration / malicious activities. Roleplay-as-XYZ is OK.

#### Writing patterns

Imperative form for instructions.

**Defining output formats:**
```markdown
## Report structure
ALWAYS use this exact template:
# [Title]
## Executive summary
## Key findings
## Recommendations
```

**Examples pattern:**
```markdown
## Commit message format
**Example 1:**
Input: Added user authentication with JWT tokens
Output: feat(auth): implement JWT-based authentication
```

### Writing style

Explain *why* things matter rather than heavy MUSTs. Use theory of mind; keep skills general, not over-fitted to examples. Draft, then look at it with fresh eyes and improve.

### Test cases

After drafting, come up with 2–3 realistic test prompts — what a real user would say. Share: "Here are a few test cases I'd like to try. Do these look right, or do you want to add more?" Then run them.

Save to `evals/evals.json`. No assertions yet — just prompts. You'll draft assertions while runs are in progress.

```json
{
  "skill_name": "example-skill",
  "evals": [
    {
      "id": 1,
      "prompt": "User's task prompt",
      "expected_output": "Description of expected result",
      "files": []
    }
  ]
}
```

See `references/schemas.md` for the full schema.

## Running and evaluating test cases

One continuous sequence — don't stop partway. Do NOT use `/skill-test` or any other testing skill.

Put results in `<skill-name>-workspace/` as a sibling to the skill. Within, organize by iteration (`iteration-1/`, etc.); each test case gets a directory (`eval-0/`, etc.). Create as you go.

### Step 1: Spawn all runs (with-skill AND baseline) in the same turn

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

### Step 2: While runs are in progress, draft assertions

Use the time productively. Draft quantitative assertions for each test case and explain them. If assertions already exist in `evals/evals.json`, review and explain.

Good assertions are objectively verifiable with descriptive names — they read clearly in the benchmark viewer. Subjective skills (writing style, design quality) get qualitative evaluation — don't force assertions onto things needing human judgment.

Update `eval_metadata.json` and `evals/evals.json` with assertions. Explain to the user what they'll see in the viewer.

### Step 3: As runs complete, capture timing data

Each subagent completion notification contains `total_tokens` and `duration_ms`. Save immediately to `timing.json` in the run directory:

```json
{
  "total_tokens": 84852,
  "duration_ms": 23332,
  "total_duration_seconds": 23.3
}
```

This is the only opportunity — the data comes through the notification and isn't persisted elsewhere. Process notifications as they arrive.

### Step 4: Grade, aggregate, and launch the viewer

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

5. **Tell the user**: "I've opened the results in your browser. Two tabs — 'Outputs' to click through each test case and leave feedback; 'Benchmark' for the quantitative comparison. Come back here when done."

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

### Step 5: Read the feedback

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

---

## Improving the skill

The heart of the loop. You've run tests, the user has reviewed; now make the skill better.

### How to think about improvements

1. **Generalize from the feedback.** Skills will be used many times across many prompts. The user knows these few examples in and out, but a skill that works only for them is useless. Rather than fiddly overfitting or oppressive MUSTs, if there's a stubborn issue, try different metaphors or working patterns. Cheap to try.

2. **Keep the prompt lean.** Remove what isn't pulling weight. Read transcripts, not just outputs — if the skill makes the model waste time, cut the parts causing that.

3. **Explain the why.** Today's LLMs are smart with good theory of mind — given a good harness, they can go beyond rote instructions. Even if feedback is terse or frustrated, understand the task and why the user wrote what they wrote, then transmit that understanding into the instructions. ALWAYS / NEVER in all caps or super rigid structures are yellow flags — reframe and explain reasoning when possible.

4. **Look for repeated work across test cases.** Read transcripts. If all 3 test cases produced a similar `create_docx.py` or `build_chart.py`, bundle that script. Write once, put in `scripts/`, point the skill at it. Saves every future invocation from reinventing the wheel.

Take your time mulling things over. Write a draft revision, look anew, improve. Get into the user's head.

### The iteration loop

After improving:

1. Apply improvements to the skill.
2. Rerun all test cases into `iteration-<N+1>/`, including baselines. For new skills, baseline is always `without_skill`. For existing skills, use judgment: original version vs previous iteration.
3. Launch the reviewer with `--previous-workspace` pointing at the prior iteration.
4. Wait for the user to review.
5. Read new feedback, improve again, repeat.

Keep going until the user is happy, feedback is all empty, or progress stalls.

---

## Advanced: blind comparison

For rigorous comparison between two skill versions (e.g., "is the new version actually better?"), see `agents/comparator.md` and `agents/analyzer.md`. Idea: give two outputs to an independent agent without telling which is which, let it judge, then analyze why the winner won.

Optional, requires subagents, usually unnecessary. Human review is typically sufficient.

---

## Description optimization

The description field is the primary mechanism determining whether Claude invokes a skill. After creating or improving a skill, offer to optimize.

### Step 1: Generate trigger eval queries

Create 20 eval queries — a mix of should-trigger and should-not-trigger:

```json
[
  {"query": "the user prompt", "should_trigger": true},
  {"query": "another prompt", "should_trigger": false}
]
```

Queries must be realistic — what a Claude Code / Claude.ai user would type. Concrete, specific, detailed: file paths, personal context about the user's job, column names and values, company names, URLs. Some lowercase, abbreviations, typos, casual speech. Mix of lengths. Focus on edge cases — the user will sign off.

| Bad | Good |
|-----|------|
| "Format this data" | "ok so my boss just sent me this xlsx file (its in my downloads, called something like 'Q4 sales final FINAL v2.xlsx') and she wants me to add a column that shows the profit margin as a percentage. The revenue is in column C and costs are in column D i think" |

**Should-trigger (8–10):** different phrasings of the same intent — formal and casual. Include cases where the user doesn't explicitly name the skill or file type but clearly needs it. Some uncommon use cases. Cases where this skill competes with another but should win.

**Should-not-trigger (8–10):** the most valuable are near-misses — share keywords/concepts but need something different. Adjacent domains, ambiguous phrasing where naive keyword match would trigger but shouldn't. Avoid obvious negatives — "write a fibonacci function" as a negative for a PDF skill is too easy. Make them genuinely tricky.

### Step 2: Review with user

Present the eval set via HTML template:

1. Read template from `assets/eval_review.html`.
2. Replace placeholders:
   - `__EVAL_DATA_PLACEHOLDER__` → JSON array (no quotes — JS variable assignment).
   - `__SKILL_NAME_PLACEHOLDER__` → skill name.
   - `__SKILL_DESCRIPTION_PLACEHOLDER__` → current description.
3. Write to a temp file (e.g., `/tmp/eval_review_<skill-name>.html`) and open it.
4. User edits queries, toggles should-trigger, adds/removes, clicks "Export Eval Set".
5. File downloads to `~/Downloads/eval_set.json` — check Downloads for the most recent (e.g., `eval_set (1).json`).

Bad eval queries lead to bad descriptions.

### Step 3: Run the optimization loop

Tell the user: "This will take some time — I'll run the loop in the background and check periodically."

Save the eval set to the workspace, then run in background:

```bash
python -m scripts.run_loop \
  --eval-set <path-to-trigger-eval.json> \
  --skill-path <path-to-skill> \
  --model <model-id-powering-this-session> \
  --max-iterations 5 \
  --verbose
```

Use the model ID from your system prompt so triggering matches the user's experience.

Periodically tail output to update the user on iteration + scores.

The loop splits the eval set 60% train / 40% held-out test, evaluates the current description (3 runs per query for reliable trigger rate), then calls Claude to propose improvements based on failures. Re-evaluates on train and test, iterates up to 5 times. Opens an HTML report and returns JSON with `best_description` — selected by test score (not train) to avoid overfitting.

### How skill triggering works

Skills appear in Claude's `available_skills` list with name + description. Claude decides whether to consult based on the description. Important: Claude only consults skills for tasks it can't easily handle on its own — simple one-step queries like "read this PDF" may not trigger even with a perfect description match because Claude can handle directly. Complex, multi-step, specialized queries reliably trigger.

Eval queries must be substantive enough that Claude would benefit from consulting a skill. Simple queries like "read file X" are poor test cases.

### Step 4: Apply the result

Take `best_description` from the JSON output, update SKILL.md frontmatter. Show before/after and report scores.

---

### Package and present (only if `present_files` tool is available)

If `present_files` is available, package the skill and present the .skill file:

```bash
python -m scripts.package_skill <path/to/skill-folder>
```

After packaging, direct the user to the `.skill` file path.

---

## Claude.ai-specific instructions

Core workflow is the same (draft → test → review → improve → repeat). Claude.ai doesn't have subagents, so mechanics change:

- **Running test cases:** no parallel execution. For each test, read SKILL.md and follow it yourself. One at a time. Less rigorous (you wrote the skill and you're running it), but a useful sanity check — human review compensates. Skip baselines.
- **Reviewing results:** if no browser (Claude.ai VM has no display, or remote server with no display), skip the browser reviewer. Present results in the conversation. Show prompt + output per test case. If output is a file, save it and tell them where it is. Ask inline: "How does this look?"
- **Benchmarking:** skip — relies on baseline comparisons not meaningful without subagents. Focus on qualitative feedback.
- **The iteration loop:** same — improve, rerun, ask for feedback — without the browser reviewer. Still organize results into iteration directories.
- **Description optimization:** requires `claude -p` from Claude Code. Skip on Claude.ai.
- **Blind comparison:** requires subagents. Skip.
- **Packaging:** `package_skill.py` works anywhere with Python + filesystem.
- **Updating an existing skill:**
  - Preserve the original name. Use the skill's directory name and `name` frontmatter unchanged (e.g., `research-helper`, not `research-helper-v2`).
  - Copy to a writeable location before editing. The installed path may be read-only — copy to `/tmp/skill-name/`, edit there, package from the copy.
  - For manual packaging, stage in `/tmp/` first.

---

## Cowork-specific instructions

- Subagents work. (If timeouts get severe, run tests in series.)
- No browser/display: use `--static <output_path>` to write standalone HTML. Proffer a link the user can click.
- Cowork tends to disincline Claude from generating the eval viewer. Reiterate: whether Cowork or Claude Code, always generate the eval viewer for human review **before** revising the skill yourself, using `generate_review.py` (not custom HTML). All caps: GENERATE THE EVAL VIEWER *BEFORE* evaluating inputs yourself. Get them in front of the human ASAP.
- Feedback works differently — no running server. The viewer's "Submit All Reviews" downloads `feedback.json`. Read from there (may need access request first).
- Packaging works.
- Description optimization should work — uses `claude -p` via subprocess, not browser. Save it until the skill is in good shape.
- **Updating an existing skill:** follow Claude.ai guidance above.

---

## Reference files

The `agents/` directory contains specialized subagent instructions:
- `agents/grader.md` — evaluate assertions against outputs.
- `agents/comparator.md` — blind A/B between two outputs.
- `agents/analyzer.md` — analyze why one version beat another.

The `references/` directory:
- `references/schemas.md` — JSON structures for evals.json, grading.json, etc.

---

Core loop, for emphasis:

- Figure out what the skill is about.
- Draft or edit the skill.
- Run claude-with-access-to-the-skill on test prompts.
- Evaluate outputs with the user: create benchmark.json and run `eval-viewer/generate_review.py`; run quantitative evals.
- Repeat until satisfied.
- Package the final skill and return it.

Add steps to your TodoList. In Cowork specifically: "Create evals JSON and run `eval-viewer/generate_review.py` so human can review test cases".
