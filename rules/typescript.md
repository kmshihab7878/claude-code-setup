---
paths:
  - "**/*.ts"
  - "**/*.tsx"
  - "**/tsconfig.json"
---

# TypeScript Rules

- Strict mode always — no `any` types (use `unknown` + narrowing)
- Named exports only — no default exports (better refactoring, tree-shaking)
- Interfaces for object shapes, type aliases for unions/intersections
- Use `readonly` for properties that shouldn't be reassigned
- Prefer `const` over `let` — never use `var`
- Error handling: use `Result<T, E>` pattern or explicit error types, not string throws
- React components: function components only, typed props interface
- Async: use `async/await` over `.then()` chains
- No `!` non-null assertions in production code — handle null explicitly
- Imports: use path aliases (`@/`) when available
