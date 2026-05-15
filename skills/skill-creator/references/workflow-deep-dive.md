# Skill Creator Workflow Deep Dive

Detailed workflow material extracted from `../SKILL.md`. Load this file when the
short workflow in `SKILL.md` is not enough.

## High-Level Loop

1. Decide what the skill should do.
2. Write a draft.
3. Create realistic test prompts and run Claude with access to the skill.
4. Help the user evaluate qualitatively and quantitatively.
5. Rewrite based on feedback and benchmark evidence.
6. Repeat until satisfied.
7. Expand the test set and try again at larger scale when useful.

Figure out where the user is and jump in:

- New skill request: narrow intent, draft, write tests, evaluate, iterate.
- Existing draft: go straight to eval and iteration.
- Casual ideation: collaborate without forcing evals.
- Finished skill: offer description optimization or packaging.

## Communicating With The User

Users have different comfort levels with technical terms. Pay attention to
context cues:

- "evaluation" and "benchmark" are usually acceptable.
- For "JSON" and "assertion", look for cues that the user knows them before
  using those terms without explanation.

Explain briefly when in doubt.

## Capture Intent

Start by understanding the user's intent. If the conversation already contains a
workflow to capture, extract it from history first:

- tools used
- sequence of operations
- corrections the user made
- input and output formats
- expected artifacts
- safety and privacy constraints

Ask only the missing questions that affect the skill design:

1. What should this skill enable Claude to do?
2. When should this skill trigger?
3. What output format is expected?
4. Should we set up test cases?

Skills with objectively verifiable outputs benefit from tests. Subjective
outputs often benefit more from qualitative review.

## Interview And Research

Before writing test prompts or final instructions, clarify:

- edge cases
- input formats
- output formats
- example files
- success criteria
- dependencies
- tools or MCP access
- security constraints

Inspect available tools and related skills. If research is useful and subagents
are available, run independent research in parallel; otherwise research inline.

## Draft And Write

Use the confirmed contract to draft:

- frontmatter
- invocation and trigger guidance
- workflow steps
- resource layout
- safety constraints
- validation rules
- minimal examples
- reference pointers

Keep the core instructions in `SKILL.md`. Put long examples, schemas, reference
tables, and troubleshooting detail into `references/`.

## Test Cases

After drafting, propose 2-3 realistic test prompts:

> Here are a few test cases I'd like to try. Do these look right, or do you want
> to add more?

Save prompts to `evals/evals.json`. Start without assertions if the expected
behavior is not yet crisp; draft assertions while runs are executing.

See `schemas.md` for the complete JSON structures.

## Running And Evaluating Test Cases

Use one continuous sequence. Do not stop after partial setup.

1. Spawn all runs in one turn when subagents are available.
2. For each test case, run two variants: with-skill and baseline.
3. For new skills, baseline is `without_skill`.
4. For improvements, snapshot the old version before comparing.
5. Write `eval_metadata.json` per test case with a descriptive `eval_name`.
6. Draft objective assertions while runs execute.
7. Capture `total_tokens` and `duration_ms` immediately when each completion
   notification arrives.
8. Grade outputs through `agents/grader.md`.
9. Aggregate with `python -m scripts.aggregate_benchmark`.
10. Run an analyst pass through `agents/analyzer.md`.
11. Launch the review viewer with `eval-viewer/generate_review.py`.
12. Read `feedback.json` after human review.
13. Improve the skill and rerun if needed.

Full command examples and file schemas live in `eval-workflow.md`.

## Improving Skills

Use feedback as signal, not a script.

1. Generalize from feedback. The skill must work beyond the few test prompts.
2. Keep prompts lean. Remove instructions that cause wasted work.
3. Explain why rules matter instead of adding rigid all-caps constraints.
4. Read transcripts, not only final outputs.
5. If all runs reinvent the same helper, bundle a script under `scripts/`.
6. Draft a revision, step back, then improve it before rerunning.

## Iteration Loop

After each improvement:

1. Apply edits.
2. Rerun all test cases into `iteration-N+1/`.
3. Include baselines.
4. Launch reviewer with `--previous-workspace` when comparing iterations.
5. Wait for user review.
6. Read feedback.
7. Repeat until the user is happy, feedback is empty, or progress stalls.

## Advanced Blind Comparison

For rigorous comparisons, use `agents/comparator.md` and `agents/analyzer.md`.
Give two outputs to an independent judge without revealing which skill version
produced which output. Use this when evidence matters; otherwise human review is
usually enough.

## Description Optimization

After creating or improving a skill, offer to optimize the description. The
short version:

1. Generate 20 trigger-eval queries: roughly half should trigger, half should
   not.
2. Review the eval set with the user.
3. Run `scripts/run_loop.py` with the model powering the current session.
4. Apply the best description from held-out test scoring.

Use `description-optimization.md` for prompt templates, review artifact details,
and model-ID rules.

## Packaging

If packaging is requested and supported:

```bash
python -m scripts.package_skill <path/to/skill-folder>
```

Then report the generated package artifact.

## Claude.ai Variant

Core workflow remains draft -> test -> review -> improve -> repeat, but mechanics
change:

- No subagents: run test cases one at a time.
- Skip baselines unless the environment supports them.
- If no browser is available, present prompt and output per test in the
  conversation.
- Skip benchmark automation when baseline comparison is not meaningful.
- Skip description optimization unless command-line Claude is available.
- Preserve original skill name and frontmatter when updating existing skills.
- Copy read-only installed skills to a writable workspace before editing.

## Headless Or Cowork-Like Variant

- Subagents can run, but use serial tests if timeouts are severe.
- No browser/display: generate a static review artifact with
  `--static <output-path>`.
- Generate the eval viewer before revising based on your own opinion.
- Feedback may arrive as a downloaded `feedback.json`; read that file before
  iterating.
- Packaging works when Python and filesystem access are available.
