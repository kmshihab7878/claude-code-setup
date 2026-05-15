# Validation, Troubleshooting, And Anti-Patterns

Purpose: detailed QA checklist, formula error interpretation, common failure modes, and anti-patterns for spreadsheet work.

## Formula Verification Checklist

- Test 2-3 sample references before building the full model.
- Confirm Excel columns match expected indexes.
- Remember Excel rows are 1-indexed.
- Check null values before writing formulas that assume numeric inputs.
- Search all matches, not just the first.
- Verify all cross-sheet references.
- Check denominators before division.
- Confirm all referenced cells exist.
- Test zero, negative, blank, and large-value edge cases.

## Recalc Output

`skills/xlsx/scripts/recalc.py` returns JSON:

```json
{
  "status": "success",
  "total_errors": 0,
  "total_formulas": 42,
  "error_summary": {}
}
```

If errors exist, `status` becomes `errors_found` and `error_summary` lists locations:

```json
{
  "status": "errors_found",
  "total_errors": 2,
  "total_formulas": 42,
  "error_summary": {
    "#REF!": {
      "count": 2,
      "locations": ["Sheet1!B5", "Sheet1!C10"]
    }
  }
}
```

## Common Formula Errors

- `#REF!`: invalid cell reference.
- `#DIV/0!`: denominator is zero or blank.
- `#VALUE!`: wrong value type.
- `#N/A`: lookup did not find a value.
- `#NAME?`: unrecognized formula or named range.
- `#NULL!`: invalid range intersection.
- `#NUM!`: invalid numeric result.

## Troubleshooting

If formulas do not calculate:

- Confirm LibreOffice is installed.
- Run `python skills/xlsx/scripts/recalc.py <excel_file> 30`.
- Open formulas with `data_only=False`.
- Verify formulas start with `=`.

If formulas disappear:

- Check whether the workbook was opened with `data_only=True` and then saved.
- Reopen from backup or regenerate formulas.

If formatting changes unexpectedly:

- Copy styles from adjacent rows or columns.
- Avoid replacing whole sheets when updating templates.
- Preserve existing named ranges and tables.

If row or column alignment is wrong:

- Compare source row counts and destination row counts.
- Check header row offsets.
- Validate sample records before writing the full workbook.

## Anti-Patterns

- Hardcoding calculated values that should be formulas.
- Saving formula workbooks after loading with `data_only=True`.
- Overwriting a user's template styling.
- Leaving formula errors for the user to fix.
- Using color as the only semantic indicator.
- Hiding assumptions in formulas.
- Omitting units from financial model headers.
- Adding unverified source notes or private data.

## Delivery QA

- Open or inspect the workbook after saving.
- Recalculate formulas when present.
- Confirm zero formula errors.
- Confirm key sheets and ranges exist.
- Confirm formatting and widths are readable.
- Confirm no unintended secrets, local paths, or private context were introduced.
