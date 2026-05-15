# Formatting And Layout

Purpose: detailed formatting, layout, number-format, financial-model, and accessibility guidance.

## General Layout

- Use one clear purpose per sheet.
- Keep raw data, assumptions, calculations, outputs, and charts separated when possible.
- Use clear sheet names.
- Freeze header rows.
- Apply filters to tabular data.
- Set sensible column widths.
- Use readable font sizes and consistent alignment.
- Include units in headers.
- Avoid excessive merged cells in analysis tables.

## Professional Font

Use a consistent professional font unless instructed otherwise. For existing templates, match the existing font.

## Number Formats

- Years: format as text strings, such as `"2024"`.
- Currency: use `$#,##0` and include units in headers, such as `Revenue ($mm)`.
- Zeros: show as `-`, including percentages, for example `$#,##0;($#,##0);-`.
- Percentages: default to `0.0%`.
- Multiples: use `0.0x`.
- Negative values: use parentheses rather than a leading minus sign when appropriate for financial models.

## Financial Model Colors

Unless the template or user says otherwise:

- Blue text: hardcoded inputs that users can change.
- Black text: formulas and calculations.
- Green text: links to other worksheets in the same workbook.
- Red text: external links.
- Yellow background: key assumptions or cells requiring attention.

## Source Notes

Document hardcoded inputs next to the value or in a nearby source note:

```text
Source: <system/document>, <date>, <specific reference>, <URL if applicable>
```

Examples:

```text
Source: Company 10-K, FY2024, Page 45, Revenue Note, <SEC EDGAR URL>
Source: Company 10-Q, Q2 2025, Exhibit 99.1, <SEC EDGAR URL>
Source: Market data provider, <date>, <screen or dataset>
```

## Accessibility

- Do not rely on color alone for meaning.
- Use labels and notes for assumption cells.
- Keep contrast readable.
- Avoid tiny text and cramped columns.
- Prefer structured tables for repeated rows.
- Use descriptive chart titles and axis labels.

## Template Update Checklist

- Match existing conventions.
- Copy styles from adjacent rows or columns.
- Preserve print settings if present.
- Preserve freeze panes and filters.
- Preserve formulas and named ranges.
- Confirm hidden sheets should remain hidden.
