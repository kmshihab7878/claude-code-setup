# Skill Creator Examples

End-to-end examples extracted from `../SKILL.md`. These examples are intentionally
public-safe and use placeholders.

## Example 1: New Skill From A Workflow

User request:

> Turn this repeated spreadsheet cleanup process into a skill.

Process:

1. Extract the workflow from the conversation:
   - input spreadsheet format
   - cleanup steps
   - output workbook format
   - edge cases the user corrected
2. Ask only missing questions:
   - Should formulas be preserved?
   - Should hidden sheets be included?
   - What output file name pattern is expected?
3. Draft:
   - `SKILL.md`
   - `scripts/clean_workbook.py`
   - `evals/evals.json`
4. Add safety constraints:
   - do not overwrite source files
   - do not expose workbook content in chat
5. Run two eval prompts with sample files.
6. Compare with baseline.
7. Improve instructions or script.
8. Report changed files and validation evidence.

## Example 2: Existing Skill Improvement

User request:

> This skill triggers too often for generic writing tasks.

Process:

1. Preserve the existing `name`.
2. Snapshot the current skill.
3. Create trigger evals:
   - should trigger for specialized workflow requests
   - should not trigger for generic writing prompts
4. Optimize description.
5. Review held-out scores.
6. Apply the new description only if it improves triggering accuracy.
7. Report before/after description and scores.

## Example 3: Skill With References

Good folder shape:

```text
cloud-cost-audit/
  SKILL.md
  references/
    aws.md
    gcp.md
    azure.md
    optimization-patterns.md
  scripts/
    parse_bill.py
  evals/
    evals.json
```

`SKILL.md` should route:

- read `aws.md` only for AWS billing data
- read `gcp.md` only for GCP billing data
- read `azure.md` only for Azure billing data
- read `optimization-patterns.md` when recommending savings

Do not paste all cloud-provider detail into the main file.

## Example 4: Minimal Evals

```json
{
  "skill_name": "invoice-normalizer",
  "evals": [
    {
      "id": 1,
      "prompt": "Normalize these invoices into the standard CSV format.",
      "expected_output": "Creates a CSV with vendor, invoice number, date, amount, and currency.",
      "files": ["evals/files/invoices.pdf"]
    },
    {
      "id": 2,
      "prompt": "Extract invoice rows and flag missing tax IDs.",
      "expected_output": "Creates a CSV and a short report listing invoices with missing tax IDs.",
      "files": ["evals/files/mixed-invoices.zip"]
    }
  ]
}
```

## Example 5: Final Report

```markdown
Created `invoice-normalizer`.

Files:
- `skills/invoice-normalizer/SKILL.md`
- `skills/invoice-normalizer/scripts/normalize.py`
- `skills/invoice-normalizer/evals/evals.json`

Validation:
- frontmatter present
- script ran on sample invoice set
- eval 1 passed 4/4 assertions
- eval 2 passed 3/4 assertions

Known limitation:
- handwritten invoices still need manual review

Next iteration:
- add OCR confidence scoring and a handwritten-invoice eval
```
