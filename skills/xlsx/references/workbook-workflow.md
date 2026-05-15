# Workbook Workflow

Purpose: detailed workbook construction, reading, editing, and conversion guidance for XLSX tasks.

## Tool Selection

- `pandas`: best for data analysis, bulk transformations, joins, cleaning, profiling, and simple exports.
- `openpyxl`: best for formulas, formatting, charts, workbook structures, and preserving existing Excel files.
- Recalculation script: use `skills/xlsx/scripts/recalc.py` after adding or changing formulas.

## Read And Analyze With pandas

```python
import pandas as pd

df = pd.read_excel("file.xlsx")
all_sheets = pd.read_excel("file.xlsx", sheet_name=None)

df.head()
df.info()
df.describe()

df.to_excel("output.xlsx", index=False)
```

## Create A Workbook With openpyxl

```python
from openpyxl import Workbook
from openpyxl.styles import Alignment, Font, PatternFill

wb = Workbook()
sheet = wb.active
sheet.title = "Summary"

sheet["A1"] = "Metric"
sheet["B1"] = "Value"
sheet.append(["Revenue", 1000])
sheet["B3"] = "=SUM(B2:B2)"

sheet["A1"].font = Font(bold=True)
sheet["B1"].fill = PatternFill("solid", start_color="D9EAF7")
sheet["A1"].alignment = Alignment(horizontal="center")
sheet.column_dimensions["A"].width = 20

wb.save("output.xlsx")
```

## Edit Existing Workbooks

```python
from openpyxl import load_workbook

wb = load_workbook("existing.xlsx")
sheet = wb.active

for sheet_name in wb.sheetnames:
    ws = wb[sheet_name]
    print(f"Sheet: {sheet_name}")

sheet["A1"] = "New Value"
sheet.insert_rows(2)
sheet.delete_cols(3)

new_sheet = wb.create_sheet("NewSheet")
new_sheet["A1"] = "Data"

wb.save("modified.xlsx")
```

## Template Preservation

When updating a workbook template:

- Inspect sheet order, hidden sheets, freeze panes, filters, styles, named ranges, formulas, and merged cells.
- Preserve formulas unless the user asks to replace them.
- Match existing font, fills, borders, widths, row heights, and number formats.
- Add rows or columns by copying styles from nearby rows or columns.
- Do not impose a new design system on an established template.

## Large File Tips

- Use `read_only=True` for reading large files.
- Use `write_only=True` for writing large exports.
- Read specific columns with `usecols`.
- Set `dtype` for IDs and codes to prevent lost leading zeros.
- Parse dates intentionally with `parse_dates`.

```python
df = pd.read_excel(
    "file.xlsx",
    usecols=["A", "C", "E"],
    dtype={"id": str},
    parse_dates=["date_column"],
)
```
