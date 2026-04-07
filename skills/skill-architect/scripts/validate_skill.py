#!/usr/bin/env python3
"""Validate a Claude Code skill directory.

Runs 13 checks across structural, frontmatter, and content categories.
Uses only Python stdlib — no external dependencies.

Usage:
    python3 validate_skill.py <path-to-skill-dir>
    python3 validate_skill.py <path-to-skill-dir> --json
    python3 validate_skill.py <path-to-skill-dir> --strict
    python3 validate_skill.py <path-to-skill-dir> --verbose
"""

from __future__ import annotations

import argparse
import json
import os
import re
import sys
from pathlib import Path
from typing import Optional


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

KEBAB_RE = re.compile(r"^[a-z][a-z0-9]*(-[a-z0-9]+)*$")
FORBIDDEN_NAME_TERMS = {"claude", "anthropic", "plugin", "extension"}
ANGLE_BRACKET_RE = re.compile(r"<[^>]+>")
IMPORT_RE = re.compile(r"^\s*(?:import|from)\s+(\S+)")

# Stdlib top-level module names (subset — covers the common ones)
STDLIB_MODULES = {
    "__future__", "abc", "argparse", "ast", "asyncio", "base64", "bisect",
    "calendar", "codecs", "collections", "colorsys", "concurrent", "configparser",
    "contextlib", "copy", "csv", "ctypes", "dataclasses", "datetime", "decimal",
    "difflib", "dis", "email", "enum", "errno", "fcntl", "fileinput", "fnmatch",
    "fractions", "ftplib", "functools", "gc", "getpass", "gettext", "glob",
    "gzip", "hashlib", "heapq", "hmac", "html", "http", "imaplib", "importlib",
    "inspect", "io", "ipaddress", "itertools", "json", "keyword", "linecache",
    "locale", "logging", "lzma", "mailbox", "math", "mimetypes", "multiprocessing",
    "numbers", "operator", "optparse", "os", "pathlib", "pickle", "platform",
    "plistlib", "pprint", "profile", "pstats", "py_compile", "queue", "random",
    "re", "readline", "reprlib", "resource", "runpy", "sched", "secrets",
    "select", "selectors", "shelve", "shlex", "shutil", "signal", "site",
    "smtplib", "sndhdr", "socket", "socketserver", "sqlite3", "ssl", "stat",
    "statistics", "string", "struct", "subprocess", "sunau", "symtable", "sys",
    "sysconfig", "syslog", "tabnanny", "tarfile", "tempfile", "termios", "test",
    "textwrap", "threading", "time", "timeit", "token", "tokenize", "tomllib",
    "trace", "traceback", "tracemalloc", "tty", "turtle", "types", "typing",
    "unicodedata", "unittest", "urllib", "uuid", "venv", "warnings", "wave",
    "weakref", "webbrowser", "xml", "xmlrpc", "zipfile", "zipimport", "zlib",
    "_thread",
}


def parse_frontmatter(text: str) -> tuple[Optional[dict[str, str]], str]:
    """Parse YAML-like frontmatter delimited by --- lines.

    Returns (fields_dict, body) or (None, full_text) if no frontmatter.
    """
    lines = text.split("\n")
    if not lines or lines[0].strip() != "---":
        return None, text

    end_idx = None
    for i in range(1, len(lines)):
        if lines[i].strip() == "---":
            end_idx = i
            break

    if end_idx is None:
        return None, text

    fm_lines = lines[1:end_idx]
    fields: dict[str, str] = {}
    current_key: Optional[str] = None
    current_val_parts: list[str] = []

    def flush() -> None:
        nonlocal current_key, current_val_parts
        if current_key is not None:
            fields[current_key] = " ".join(current_val_parts).strip()
            current_key = None
            current_val_parts = []

    for line in fm_lines:
        stripped = line.strip()
        if not stripped or stripped.startswith("#"):
            continue
        # Check for key: value
        colon_match = re.match(r"^([a-zA-Z_-]+)\s*:\s*(.*)", line)
        if colon_match and not line[0].isspace():
            flush()
            current_key = colon_match.group(1).strip()
            val = colon_match.group(2).strip()
            if val == ">":
                val = ""
            current_val_parts = [val] if val else []
        elif current_key is not None:
            # Continuation line
            current_val_parts.append(stripped)

    flush()

    body = "\n".join(lines[end_idx + 1 :])
    return fields, body


def count_words(text: str) -> int:
    """Count words in text, excluding code blocks and frontmatter."""
    # Remove frontmatter
    _, body = parse_frontmatter(text)
    # Remove code blocks
    body = re.sub(r"```[\s\S]*?```", "", body)
    return len(body.split())


def has_external_imports(filepath: Path) -> list[str]:
    """Return list of external (non-stdlib) imports in a Python file."""
    external: list[str] = []
    try:
        content = filepath.read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError):
        return external

    for line in content.split("\n"):
        m = IMPORT_RE.match(line)
        if m:
            top_module = m.group(1).split(".")[0]
            if top_module not in STDLIB_MODULES and not top_module.startswith("_"):
                external.append(top_module)
    return external


# ---------------------------------------------------------------------------
# Check functions
# ---------------------------------------------------------------------------

class CheckResult:
    """Result of a single validation check."""

    def __init__(self, name: str, category: str, passed: bool, message: str) -> None:
        self.name = name
        self.category = category
        self.passed = passed
        self.message = message

    def to_dict(self) -> dict[str, str | bool]:
        return {
            "name": self.name,
            "category": self.category,
            "passed": self.passed,
            "message": self.message,
        }


def check_skill_md_exists(skill_dir: Path) -> CheckResult:
    """S1: SKILL.md must exist."""
    exists = (skill_dir / "SKILL.md").is_file()
    return CheckResult(
        "skill-md-exists",
        "structural",
        exists,
        "SKILL.md found" if exists else "SKILL.md not found",
    )


def check_no_readme_conflict(skill_dir: Path) -> CheckResult:
    """S2: No README.md that could conflict with SKILL.md."""
    has_readme = (skill_dir / "README.md").is_file()
    has_skill = (skill_dir / "SKILL.md").is_file()
    passed = not (has_readme and has_skill)
    msg = (
        "Both README.md and SKILL.md present — remove README.md"
        if not passed
        else "No README.md conflict"
    )
    return CheckResult("no-readme-conflict", "structural", passed, msg)


def check_folder_matches_name(
    skill_dir: Path, fm_fields: Optional[dict[str, str]]
) -> CheckResult:
    """S3: Folder name matches frontmatter name field."""
    folder_name = skill_dir.name
    if fm_fields is None or "name" not in fm_fields:
        return CheckResult(
            "folder-matches-name",
            "structural",
            False,
            "Cannot check — no frontmatter name field",
        )
    fm_name = fm_fields["name"].strip().strip('"').strip("'")
    passed = folder_name == fm_name
    msg = (
        f"Folder '{folder_name}' matches name '{fm_name}'"
        if passed
        else f"Folder '{folder_name}' does not match name '{fm_name}'"
    )
    return CheckResult("folder-matches-name", "structural", passed, msg)


def check_folder_kebab_case(skill_dir: Path) -> CheckResult:
    """S4: Folder name is kebab-case."""
    name = skill_dir.name
    passed = bool(KEBAB_RE.match(name))
    return CheckResult(
        "folder-kebab-case",
        "structural",
        passed,
        f"'{name}' is valid kebab-case" if passed else f"'{name}' is not kebab-case",
    )


def check_no_external_imports(skill_dir: Path) -> CheckResult:
    """S5: Scripts use only stdlib imports."""
    scripts_dir = skill_dir / "scripts"
    if not scripts_dir.is_dir():
        return CheckResult(
            "no-external-imports", "structural", True, "No scripts directory"
        )

    all_external: list[str] = []
    for py_file in scripts_dir.rglob("*.py"):
        ext = has_external_imports(py_file)
        if ext:
            all_external.extend(f"{py_file.name}: {m}" for m in ext)

    passed = len(all_external) == 0
    msg = (
        "All scripts use stdlib only"
        if passed
        else f"External imports found: {', '.join(all_external)}"
    )
    return CheckResult("no-external-imports", "structural", passed, msg)


def check_yaml_delimiters(text: str) -> CheckResult:
    """F1: YAML frontmatter delimiters present."""
    lines = text.strip().split("\n")
    has_open = len(lines) > 0 and lines[0].strip() == "---"
    has_close = any(line.strip() == "---" for line in lines[1:]) if has_open else False
    passed = has_open and has_close
    return CheckResult(
        "yaml-delimiters",
        "frontmatter",
        passed,
        "YAML delimiters found" if passed else "Missing --- delimiters",
    )


def check_name_kebab(fm_fields: Optional[dict[str, str]]) -> CheckResult:
    """F2: Name field is valid kebab-case."""
    if fm_fields is None or "name" not in fm_fields:
        return CheckResult(
            "name-kebab", "frontmatter", False, "No name field in frontmatter"
        )
    name = fm_fields["name"].strip().strip('"').strip("'")
    passed = bool(KEBAB_RE.match(name))
    return CheckResult(
        "name-kebab",
        "frontmatter",
        passed,
        f"'{name}' is valid kebab-case" if passed else f"'{name}' is not kebab-case",
    )


def check_no_forbidden_terms(fm_fields: Optional[dict[str, str]]) -> CheckResult:
    """F3: Name does not contain forbidden terms."""
    if fm_fields is None or "name" not in fm_fields:
        return CheckResult(
            "no-forbidden-terms", "frontmatter", False, "No name field"
        )
    name = fm_fields["name"].strip().strip('"').strip("'").lower()
    found = [t for t in FORBIDDEN_NAME_TERMS if t in name.split("-")]
    passed = len(found) == 0
    msg = (
        "No forbidden terms in name"
        if passed
        else f"Forbidden terms found: {', '.join(found)}"
    )
    return CheckResult("no-forbidden-terms", "frontmatter", passed, msg)


def check_description_present(fm_fields: Optional[dict[str, str]]) -> CheckResult:
    """F4: Description field is present and non-empty."""
    if fm_fields is None or "description" not in fm_fields:
        return CheckResult(
            "description-present", "frontmatter", False, "No description field"
        )
    desc = fm_fields["description"].strip()
    passed = len(desc) > 0
    return CheckResult(
        "description-present",
        "frontmatter",
        passed,
        f"Description present ({len(desc)} chars)"
        if passed
        else "Description is empty",
    )


def check_description_length(fm_fields: Optional[dict[str, str]]) -> CheckResult:
    """F5: Description under 1024 characters."""
    if fm_fields is None or "description" not in fm_fields:
        return CheckResult(
            "description-length", "frontmatter", False, "No description field"
        )
    desc = fm_fields["description"].strip()
    passed = len(desc) <= 1024
    msg = (
        f"Description is {len(desc)} chars (limit: 1024)"
        if passed
        else f"Description too long: {len(desc)} chars (limit: 1024)"
    )
    return CheckResult("description-length", "frontmatter", passed, msg)


def check_no_angle_brackets(fm_fields: Optional[dict[str, str]]) -> CheckResult:
    """F6: No angle brackets in frontmatter values (breaks parsing)."""
    if fm_fields is None:
        return CheckResult(
            "no-angle-brackets", "frontmatter", False, "No frontmatter"
        )
    violations: list[str] = []
    for key, val in fm_fields.items():
        if ANGLE_BRACKET_RE.search(val):
            violations.append(key)
    passed = len(violations) == 0
    msg = (
        "No angle brackets in frontmatter"
        if passed
        else f"Angle brackets found in: {', '.join(violations)}"
    )
    return CheckResult("no-angle-brackets", "frontmatter", passed, msg)


def check_word_count(text: str) -> CheckResult:
    """C1: Word count under 5000."""
    wc = count_words(text)
    passed = wc <= 5000
    msg = (
        f"Word count: {wc} (limit: 5000)"
        if passed
        else f"Word count too high: {wc} (limit: 5000)"
    )
    return CheckResult("word-count", "content", passed, msg)


def check_when_section(text: str) -> CheckResult:
    """C2: Has a 'when to apply' or 'when to use' section."""
    lower = text.lower()
    patterns = ["when to apply", "when to use", "## when to"]
    found = any(p in lower for p in patterns)
    return CheckResult(
        "when-section",
        "content",
        found,
        "Has 'when to' section" if found else "Missing 'when to apply/use' section",
    )


# ---------------------------------------------------------------------------
# Runner
# ---------------------------------------------------------------------------

def validate_skill(skill_dir: Path, verbose: bool = False) -> list[CheckResult]:
    """Run all 13 checks on a skill directory."""
    results: list[CheckResult] = []

    # Read SKILL.md if it exists
    skill_md_path = skill_dir / "SKILL.md"
    text = ""
    fm_fields: Optional[dict[str, str]] = None
    if skill_md_path.is_file():
        text = skill_md_path.read_text(encoding="utf-8")
        fm_fields, _ = parse_frontmatter(text)

    # Structural checks (S1-S5)
    results.append(check_skill_md_exists(skill_dir))
    results.append(check_no_readme_conflict(skill_dir))
    results.append(check_folder_matches_name(skill_dir, fm_fields))
    results.append(check_folder_kebab_case(skill_dir))
    results.append(check_no_external_imports(skill_dir))

    # Frontmatter checks (F1-F6)
    results.append(check_yaml_delimiters(text))
    results.append(check_name_kebab(fm_fields))
    results.append(check_no_forbidden_terms(fm_fields))
    results.append(check_description_present(fm_fields))
    results.append(check_description_length(fm_fields))
    results.append(check_no_angle_brackets(fm_fields))

    # Content checks (C1-C2)
    results.append(check_word_count(text))
    results.append(check_when_section(text))

    return results


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Validate a Claude Code skill directory"
    )
    parser.add_argument("path", help="Path to skill directory")
    parser.add_argument("--json", action="store_true", help="Output JSON")
    parser.add_argument(
        "--strict",
        action="store_true",
        help="Exit 1 on any failure (default: exit 1 only on structural/frontmatter failures)",
    )
    parser.add_argument("--verbose", action="store_true", help="Show all check details")
    args = parser.parse_args()

    skill_dir = Path(args.path).resolve()
    if not skill_dir.is_dir():
        print(f"Error: '{skill_dir}' is not a directory", file=sys.stderr)
        sys.exit(2)

    results = validate_skill(skill_dir, verbose=args.verbose)

    if args.json:
        output = {
            "skill": skill_dir.name,
            "path": str(skill_dir),
            "passed": all(r.passed for r in results),
            "summary": {
                "total": len(results),
                "passed": sum(1 for r in results if r.passed),
                "failed": sum(1 for r in results if not r.passed),
            },
            "checks": [r.to_dict() for r in results],
        }
        print(json.dumps(output, indent=2))
    else:
        print(f"\nValidating: {skill_dir.name}")
        print(f"{'=' * 50}")

        for cat in ("structural", "frontmatter", "content"):
            cat_results = [r for r in results if r.category == cat]
            print(f"\n{cat.upper()} ({len(cat_results)} checks):")
            for r in cat_results:
                icon = "PASS" if r.passed else "FAIL"
                print(f"  [{icon}] {r.name}: {r.message}")

        total = len(results)
        passed = sum(1 for r in results if r.passed)
        failed = total - passed
        print(f"\n{'=' * 50}")
        print(f"Result: {passed}/{total} passed, {failed} failed")

    # Determine exit code
    if args.strict:
        has_failure = any(not r.passed for r in results)
    else:
        has_failure = any(
            not r.passed for r in results if r.category in ("structural", "frontmatter")
        )

    sys.exit(1 if has_failure else 0)


if __name__ == "__main__":
    main()
