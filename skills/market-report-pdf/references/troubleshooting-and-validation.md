# PDF Report Troubleshooting and Validation

This reference contains PDF generation troubleshooting and validation checks.

## Troubleshooting

| Issue | Solution |
|---|---|
| `ModuleNotFoundError: No module named 'reportlab'` | Ask before installing, then run `pip3 install reportlab` if approved |
| Script produces empty PDF | Check that JSON has required fields |
| Score gauge not rendering | Ensure `overall_score` is numeric 0-100 |
| Competitor table missing | Ensure `competitors` has `name`, `positioning`, `pricing`, `social_proof`, and `content` |
| PDF is only one page | Check JSON parse errors |
| Fonts look wrong | The script uses built-in Helvetica; no custom fonts required |

## JSON Validation

```bash
python3 -c "import json; json.load(open('/tmp/report_data.json'))"
```

Check:

- JSON parses.
- Required fields exist.
- Category names match expected values.
- Scores are integers from 0 to 100.
- Findings include supported severity labels.
- Action arrays are not empty.
- Competitor data is either complete or omitted.

## PDF Validation

```bash
ls -la "MARKETING-REPORT-<domain>.pdf"
```

Report:

- Output path.
- File size.
- Optional sections included.
- Missing data or assumptions.

## Quality Checks

- Every score is defensible.
- Findings include evidence.
- Executive summary is concise.
- Action items are specific.
- Competitor data is not invented.
- Estimates are labeled.
- No private data or secrets appear in JSON or PDF.

Do not claim success until the PDF exists and has been checked.
