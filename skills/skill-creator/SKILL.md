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

**Anatomy:** `SKILL.md` (required, with YAML frontmatter `name` + `description`) + optional `scripts/` (executable code), `references/` (lazy docs), `assets/` (output templates).

**Progressive disclosure:** metadata always in context, SKILL.md body loads when triggered, bundled resources load on demand. Keep SKILL.md under 500 lines; add hierarchy + pointers when approaching. Large reference files (>300 lines) need a table of contents.

**Multi-variant domains:** organize by variant under `references/` (e.g. `references/aws.md`, `references/gcp.md`) so Claude reads only the relevant one.

**Principle of lack of surprise:** no malware, exploit code, content that compromises security, or misleading-skill creation. Don't facilitate unauthorized access, data exfiltration, or malicious activities. Roleplay-as-XYZ is OK.

**Writing style:** imperative instructions. Explain *why* rather than heavy MUSTs. Use theory of mind; keep general, not over-fitted to examples. Draft, look anew, improve.

Anatomy diagram, full progressive-disclosure pattern, multi-variant directory layout, and the two writing-pattern code templates: [`references/skill-template-reference.md`](references/skill-template-reference.md).

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

One continuous sequence — don't stop partway. Do **NOT** use `/skill-test` or any other testing skill.

Workspace layout: `<skill-name>-workspace/` as a sibling to the skill, organized by iteration (`iteration-1/`, etc.) with one directory per test case (`eval-0/`, etc.). Create as you go.

Five-step sequence (full per-step procedure, schemas, and viewer detail in [`references/eval-workflow.md`](references/eval-workflow.md)):

1. **Spawn all runs in one turn** — for each test case spawn two subagents (with-skill + baseline) simultaneously. Baseline is `without_skill` for new skills; snapshot the old version (`cp -r <skill-path> <workspace>/skill-snapshot/`) and use that for improvements. Write `eval_metadata.json` per test case with a descriptive `eval_name`.
2. **While runs run, draft assertions** — objectively verifiable, descriptive names. Don't force assertions on subjective skills.
3. **Capture timing** — each completion notification has `total_tokens` and `duration_ms`. Save to `timing.json` immediately; this is the only opportunity.
4. **Grade, aggregate, view** — grade via `agents/grader.md` (writing `grading.json` with `text` / `passed` / `evidence` fields — the viewer depends on these exact names), aggregate with `python -m scripts.aggregate_benchmark <workspace>/iteration-N --skill-name <name>`, analyst-pass via `agents/analyzer.md`, then launch the viewer:
   ```bash
   nohup python <skill-creator-path>/eval-viewer/generate_review.py \
     <workspace>/iteration-N \
     --skill-name "my-skill" \
     --benchmark <workspace>/iteration-N/benchmark.json \
     > /dev/null 2>&1 &
   VIEWER_PID=$!
   ```
   Iteration 2+: pass `--previous-workspace`. Headless / Cowork: pass `--static <output>`. Always use `generate_review.py` — never custom HTML.
5. **Read `feedback.json`** when the user's done; focus improvements where complaints are specific; `kill $VIEWER_PID` afterward.

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

Four-step procedure (full detail, prompt templates, and the model-ID rule in [`references/description-optimization.md`](references/description-optimization.md)):

1. **Generate 20 trigger-eval queries** (8–10 should-trigger + 8–10 should-not-trigger). Realistic, specific, concrete — file paths, job context, real-looking column names, casual speech and typos. Should-not-trigger entries should be near-misses, not obvious negatives.
2. **Review with user** via `assets/eval_review.html` — substitute `__EVAL_DATA_PLACEHOLDER__`, `__SKILL_NAME_PLACEHOLDER__`, `__SKILL_DESCRIPTION_PLACEHOLDER__`; user edits and exports `eval_set.json` (check `~/Downloads/` for the latest copy).
3. **Run the optimization loop** in the background, using the model ID from the current session:
   ```bash
   python -m scripts.run_loop \
     --eval-set <path-to-trigger-eval.json> \
     --skill-path <path-to-skill> \
     --model <model-id-powering-this-session> \
     --max-iterations 5 \
     --verbose
   ```
   60% train / 40% held-out test, 3 runs per query, up to 5 iterations. Returns `best_description` selected on test score (not train) to avoid overfitting.
4. **Apply the result** — update SKILL.md frontmatter with `best_description`. Show before/after and report scores.

**How skill triggering works (essentials):** Claude only consults skills for tasks it can't handle directly. Simple one-step queries ("read this PDF") may not trigger even with perfect descriptions; complex, multi-step, specialized queries reliably trigger. Make eval queries substantive enough that Claude would actually benefit from the skill.

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

The `references/` directory (load on demand):
- [`references/skill-template-reference.md`](references/skill-template-reference.md) — anatomy diagram, progressive disclosure, multi-variant layout, writing patterns + examples.
- [`references/eval-workflow.md`](references/eval-workflow.md) — full 5-step eval-and-review procedure, schemas, viewer detail.
- [`references/description-optimization.md`](references/description-optimization.md) — full 4-step description-optimization procedure.
- [`references/schemas.md`](references/schemas.md) — JSON structures for `evals.json`, `grading.json`, etc.

---

Core loop, for emphasis:

- Figure out what the skill is about.
- Draft or edit the skill.
- Run claude-with-access-to-the-skill on test prompts.
- Evaluate outputs with the user: create benchmark.json and run `eval-viewer/generate_review.py`; run quantitative evals.
- Repeat until satisfied.
- Package the final skill and return it.

Add steps to your TodoList. In Cowork specifically: "Create evals JSON and run `eval-viewer/generate_review.py` so human can review test cases".
