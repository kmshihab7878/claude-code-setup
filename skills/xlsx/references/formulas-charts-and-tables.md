# Formulas, Charts, And Tables

Purpose: detailed formula integrity rules, formula examples, chart patterns, and table construction guidance.

## Use Formulas, Not Hardcoded Calculations

Calculated workbook values should remain dynamic.

Wrong:

```python
total = df["Sales"].sum()
sheet["B10"] = total

growth = (df.iloc[-1]["Revenue"] - df.iloc[0]["Revenue"]) / df.iloc[0]["Revenue"]
sheet["C5"] = growth
```

Correct:

```python
sheet["B10"] = "=SUM(B2:B9)"
sheet["C5"] = "=(C4-C2)/C2"
sheet["D20"] = "=AVERAGE(D2:D19)"
```

## Formula Construction Rules

- Place assumptions in separate cells.
- Use references instead of formula hardcodes.
- Use absolute references for shared assumptions, such as `$B$6`.
- Test 2-3 sample formulas before filling ranges.
- Verify row and column offsets.
- Avoid unintended circular references.
- Protect denominator references with appropriate logic when division by zero is possible.

Example:

```python
sheet["B6"] = 0.05
sheet["B7"] = "=B5*(1+$B$6)"
```

## Cross-Sheet References

Use valid sheet references:

```python
summary["B2"] = "='Raw Data'!B10"
summary["B3"] = "=SUM('Monthly Data'!B2:B13)"
```

## Tables

Use Excel tables for repeated data ranges when users need filtering and structured layout.

```python
from openpyxl.worksheet.table import Table, TableStyleInfo

table = Table(displayName="SalesTable", ref="A1:D20")
style = TableStyleInfo(
    name="TableStyleMedium9",
    showFirstColumn=False,
    showLastColumn=False,
    showRowStripes=True,
    showColumnStripes=False,
)
table.tableStyleInfo = style
sheet.add_table(table)
```

## Charts

Create charts only when they clarify comparison, trend, composition, or distribution.

```python
from openpyxl.chart import LineChart, Reference

chart = LineChart()
chart.title = "Revenue Trend"
chart.y_axis.title = "Revenue ($mm)"
chart.x_axis.title = "Year"

data = Reference(sheet, min_col=2, min_row=1, max_row=6)
cats = Reference(sheet, min_col=1, min_row=2, max_row=6)
chart.add_data(data, titles_from_data=True)
chart.set_categories(cats)

sheet.add_chart(chart, "E2")
```

## Chart Selection

- Line chart: time series or trend.
- Bar chart: category comparison.
- Stacked bar: composition with clear totals.
- Scatter: relationship between numeric variables.
- Waterfall: bridge from one value to another.
- Avoid pie charts when categories are numerous or differences are small.

## Formula Recalculation

After adding or changing formulas:

```bash
python skills/xlsx/scripts/recalc.py <excel_file> [timeout_seconds]
```

The script recalculates formulas with LibreOffice, scans for Excel error values, and returns JSON.
