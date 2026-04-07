# OCR & PDF Conversion Reference

> Supplementary reference for the PDF skill
> Covers: EasyOCR multi-language OCR, PDF-to-Markdown conversion

---

## EasyOCR (80+ Languages)

### Installation
```bash
pip install easyocr
# GPU support (optional, much faster)
pip install easyocr torch torchvision
```

### Basic Usage
```python
import easyocr

# Initialize reader (downloads models on first use)
reader = easyocr.Reader(['en'])  # English only
reader_multi = easyocr.Reader(['en', 'ar', 'fr'])  # Multi-language

# Read from file
results = reader.readtext('document.png')
# Returns: [(bbox, text, confidence), ...]

# Read from numpy array
import cv2
image = cv2.imread('document.png')
results = reader.readtext(image)

# Extract text only
texts = reader.readtext('document.png', detail=0)
# Returns: ['text1', 'text2', ...]
```

### PDF OCR with EasyOCR
```python
from pdf2image import convert_from_path
import easyocr

def ocr_pdf_easyocr(
    pdf_path: str,
    languages: list[str] = ['en'],
    gpu: bool = True,
) -> str:
    """OCR a PDF using EasyOCR (better for non-Latin scripts)."""
    reader = easyocr.Reader(languages, gpu=gpu)
    images = convert_from_path(pdf_path)

    full_text = ""
    for i, image in enumerate(images):
        import numpy as np
        image_np = np.array(image)
        results = reader.readtext(image_np, detail=0, paragraph=True)
        full_text += f"\n--- Page {i+1} ---\n"
        full_text += "\n".join(results)

    return full_text
```

### EasyOCR vs pytesseract

| Feature | EasyOCR | pytesseract |
|---------|---------|-------------|
| Languages | 80+ | 100+ |
| Installation | `pip install easyocr` | Requires Tesseract binary |
| GPU Support | Yes (PyTorch) | No |
| Accuracy (Latin) | Good | Good |
| Accuracy (CJK) | Excellent | Good |
| Accuracy (Arabic) | Excellent | Fair |
| Accuracy (handwriting) | Fair | Poor |
| Speed (CPU) | Slower | Faster |
| Speed (GPU) | Much faster | N/A |
| Dependencies | Heavy (PyTorch) | Light |
| Model size | 50-100MB per language | 10-30MB per language |

### When to Use Which

| Scenario | Recommended | Why |
|----------|-------------|-----|
| English-only, speed matters | pytesseract | Lighter, faster on CPU |
| Multi-language (CJK, Arabic) | EasyOCR | Better non-Latin accuracy |
| GPU available | EasyOCR | Huge speed boost with GPU |
| Minimal dependencies | pytesseract | Lighter install |
| Handwritten text | EasyOCR | Better detection |
| High-volume batch | pytesseract (CPU) or EasyOCR (GPU) | Depends on hardware |

### Supported Languages (Selected)
```
English (en), Arabic (ar), Chinese Simplified (ch_sim), Chinese Traditional (ch_tra),
Japanese (ja), Korean (ko), French (fr), German (de), Spanish (es), Portuguese (pt),
Russian (ru), Hindi (hi), Thai (th), Vietnamese (vi), Turkish (tr), Ukrainian (uk),
Polish (pl), Dutch (nl), Italian (it), Indonesian (id), Malay (ms), Bengali (bn),
Tamil (ta), Telugu (te), Urdu (ur), Persian (fa), Hebrew (he), Georgian (ka)
```

---

## PDF to Markdown Conversion

### When to Convert PDF→MD vs Extract Text

| Use Case | Approach |
|----------|----------|
| Need structured content (headers, lists) | PDF→MD conversion |
| Need just the text | `pdfplumber.extract_text()` |
| Need table data | `pdfplumber.extract_tables()` → pandas |
| Need to preserve layout | PDF→MD with layout preservation |
| Need images + text | Extract images separately + text |

### pdf3md Patterns
```python
# Pattern: PDF to Markdown preserving structure
import pdfplumber

def pdf_to_markdown(pdf_path: str) -> str:
    """Convert PDF to Markdown with basic structure detection."""
    md_lines: list[str] = []

    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            text = page.extract_text()
            if not text:
                continue

            for line in text.split('\n'):
                line = line.strip()
                if not line:
                    md_lines.append('')
                    continue

                # Detect headers (heuristic: short, bold/large, title-case)
                if len(line) < 80 and line[0].isupper() and not line.endswith('.'):
                    words = line.split()
                    if len(words) <= 8:
                        md_lines.append(f'## {line}')
                        continue

                # Detect bullet points
                if line.startswith(('•', '●', '○', '-', '*')):
                    md_lines.append(f'- {line[1:].strip()}')
                    continue

                # Detect numbered lists
                if len(line) > 2 and line[0].isdigit() and line[1] in '.):':
                    md_lines.append(line)
                    continue

                md_lines.append(line)

            # Extract tables
            tables = page.extract_tables()
            for table in tables:
                if table and len(table) > 1:
                    # Header row
                    headers = table[0]
                    md_lines.append('')
                    md_lines.append('| ' + ' | '.join(str(h or '') for h in headers) + ' |')
                    md_lines.append('| ' + ' | '.join('---' for _ in headers) + ' |')
                    for row in table[1:]:
                        md_lines.append('| ' + ' | '.join(str(c or '') for c in row) + ' |')
                    md_lines.append('')

    return '\n'.join(md_lines)
```

### Batch Conversion
```python
from pathlib import Path

def batch_pdf_to_md(input_dir: str, output_dir: str) -> list[str]:
    """Convert all PDFs in a directory to Markdown."""
    input_path = Path(input_dir)
    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)

    converted = []
    for pdf_file in input_path.glob('*.pdf'):
        md_content = pdf_to_markdown(str(pdf_file))
        md_file = output_path / f'{pdf_file.stem}.md'
        md_file.write_text(md_content)
        converted.append(str(md_file))

    return converted
```

---

## Integration with Document Handling Skill

The `document-handling` skill provides general document parsing patterns. This OCR reference extends it with:
- Multi-language OCR capabilities (EasyOCR)
- Structured PDF→MD conversion
- GPU-accelerated OCR for batch processing
