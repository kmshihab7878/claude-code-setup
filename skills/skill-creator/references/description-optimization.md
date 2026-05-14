# Description optimization (full procedure)

The description field is the primary mechanism determining whether Claude invokes a skill. After creating or improving a skill, offer to optimize. SKILL.md keeps the offer-to-optimize signal; this file holds the four-step procedure.

## Step 1: Generate trigger eval queries

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

## Step 2: Review with user

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

## Step 3: Run the optimization loop

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

## Step 4: Apply the result

Take `best_description` from the JSON output, update SKILL.md frontmatter. Show before/after and report scores.
