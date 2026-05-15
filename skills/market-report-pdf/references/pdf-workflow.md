# PDF Marketing Report Workflow Reference

This reference contains the detailed PDF generation workflow for `market-report-pdf`.

## Data Collection

Primary source files:

- `MARKETING-AUDIT.md`
- `LANDING-CRO.md`
- `SEO-AUDIT.md`
- `BRAND-VOICE.md`
- `COMPETITOR-ANALYSIS.md`
- `FUNNEL-ANALYSIS.md`
- `SOCIAL-AUDIT.md`
- `EMAIL-AUDIT.md`
- `AD-AUDIT.md`

If no previous data exists:

1. Recommend `/market audit <url>` for best results.
2. If the user insists, analyze the provided URL directly.
3. Use `python scripts/analyze_page.py <url>` only when available and appropriate.

## PDF vs Markdown

| Format | Best For | Pros | Cons |
|---|---|---|---|
| PDF | Client presentations, email attachments, sales collateral | Professional, visual, printable | Harder to edit, requires Python/reportlab |
| Markdown | Internal use, quick reference, iterative editing, version control | Easy to edit, git-friendly | Less polished, no charts |

Use PDF for client or prospect delivery. Use Markdown for iterative analysis.

## Write JSON File

Save assembled data to a temporary JSON file:

```bash
cat > /tmp/report_data.json << 'JSONEOF'
{
  "...": "assembled JSON data"
}
JSONEOF
```

Do not put secrets or private data in the temporary JSON.

## Prerequisite Check

Verify `reportlab`:

```bash
python3 -c "import reportlab" 2>/dev/null
```

If missing, ask before installing:

```bash
pip3 install reportlab
```

## Generate PDF

```bash
python3 scripts/generate_pdf_report.py /tmp/report_data.json "MARKETING-REPORT-<domain>.pdf"
```

Domain filename normalization examples:

- `example.com` -> `MARKETING-REPORT-example-com.pdf`
- `myapp.io` -> `MARKETING-REPORT-myapp-io.pdf`

## Demo Mode

Running the script without arguments generates a sample report:

```bash
python3 scripts/generate_pdf_report.py
```

Expected output:

```text
MARKETING-REPORT-sample.pdf
```

## Verify Output

```bash
ls -la "MARKETING-REPORT-<domain>.pdf"
```

Report the file path and size.

## Cleanup

```bash
rm /tmp/report_data.json
```

Keep the JSON only if the user asks for it.
