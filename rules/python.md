---
paths:
  - "**/*.py"
  - "**/pyproject.toml"
---

# Python Rules

- Type hints on ALL function signatures (params + return)
- No bare `except:` — always catch specific exceptions
- Use `from __future__ import annotations` for forward refs
- Prefer `pathlib.Path` over `os.path`
- Use `dataclass` or `pydantic.BaseModel` for structured data — no raw dicts for domain objects
- Imports: stdlib first, third-party second, local third (ruff enforces this)
- No mutable default arguments (`def f(items=[])` is a bug)
- Use `if __name__ == "__main__":` guard in scripts
- Async functions: use `asyncio` patterns, never `time.sleep()` in async code
- Tests: pytest with descriptive names (`test_<what>_<condition>_<expected>`)
