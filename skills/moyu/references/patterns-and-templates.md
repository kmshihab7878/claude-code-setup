# Grinding vs Moyu — full pattern catalog

The compact comparison table lives in `SKILL.md`. This reference holds the
full Grinding vs Moyu tables across six categories plus the full Anti-Grinding
table of urge → wisdom pairs.

## Grinding vs Moyu by Category

Every row is a real scenario. Left is what to avoid. Right is what to do.

### Scope Control

| Grinding (Junior) | Moyu (Senior) |
|---|---|
| Fixing bug A and "improving" functions B, C, D along the way | Fix bug A only, don't touch anything else |
| Changing one line but rewriting the entire file | Change only that line, keep everything else intact |
| Changes spreading to 5 unrelated files | Only change files that must change |
| User says "add a button," you add button + animation + a11y + i18n | User says "add a button," you add a button |

### Abstraction & Architecture

| Grinding (Junior) | Moyu (Senior) |
|---|---|
| One implementation with interface + factory + strategy | Write the implementation directly — no interface needed without a second implementation |
| Reading JSON with config class + validator + builder | `json.load(f)` |
| Splitting 30 lines into 5 files across 5 directories | 30 lines in one file |
| Creating `utils/`, `helpers/`, `services/`, `types/` | Code lives where it's used |

### Error Handling

| Grinding (Junior) | Moyu (Senior) |
|---|---|
| Wrapping every function body in try-catch | Try-catch only where errors actually occur and need handling |
| Adding null checks on TypeScript-guaranteed values | Trust the type system |
| Full parameter validation on internal functions | Validate only at system boundaries (API endpoints, user input, external data) |
| Writing fallbacks for impossible scenarios | Impossible scenarios don't need code |

### Comments & Documentation

| Grinding (Junior) | Moyu (Senior) |
|---|---|
| Writing `// increment counter` above `counter++` | The code is the documentation |
| Adding JSDoc to every function | Document only public APIs, only when asked |
| Naming variables `userAuthenticationTokenExpirationDateTime` | Naming variables `tokenExpiry` |
| Generating README sections unprompted | No docs unless the user asks |

### Dependencies

| Grinding (Junior) | Moyu (Senior) |
|---|---|
| Importing lodash for a single `_.get()` | Using optional chaining `?.` |
| Importing axios when fetch works fine | Using fetch |
| Adding a date library for a timestamp comparison | Using built-in Date methods |
| Installing packages without asking | Asking the user before adding any dependency |

### Code Modification

| Grinding (Junior) | Moyu (Senior) |
|---|---|
| Deleting code you think is "unused" | If unsure, ask — don't delete |
| Rewriting functions to be "more elegant" | Preserve existing behavior unless asked to refactor |
| Changing indentation, import order, quote style while fixing a bug | Change only functionality, don't touch formatting |
| Renaming `x` to `currentItemIndex` | Match existing code style |

### Work Approach

| Grinding (Junior) | Moyu (Senior) |
|---|---|
| Jumping straight to the most complex solution | Propose 2-3 approaches with tradeoffs, default to simplest |
| Fixing A breaks B, fixing B breaks C, keeps going | One change at a time, verify before continuing |
| Writing a full test suite nobody asked for | No tests unless the user asks |
| Building a config/ directory for a single value | A constant in the file where it's used |

## Anti-Grinding Table — full urge → wisdom catalog

When you feel any of these urges, stop. That's the grind talking.

| Your Urge | Moyu Wisdom |
|---|---|
| "This function name is bad, let me rename it" | Not your task. Note it, tell the user, but don't change it. |
| "I should add a try-catch here just in case" | Will this exception actually happen? If not, don't add it. |
| "I should extract this into a utility function" | It's called once. Inline is better than abstraction. |
| "This file should be split into smaller files" | One 200-line file is easier to understand than five 40-line files. |
| "The user probably also wants this feature" | The user didn't say so. That means no. |
| "This code isn't elegant enough, let me rewrite it" | Working code is more valuable than elegant code. Don't rewrite unless asked. |
| "I should add an interface for future extensibility" | YAGNI. You Aren't Gonna Need It. |
| "Let me add comprehensive error handling" | Handle only real error paths. Don't write code for ghosts. |
| "This needs type annotations" | If the type system can infer it, you don't need to annotate it. |
| "This value should be in a config file" | A constant is enough. |
| "Let me write tests for this too" | The user didn't ask for tests. Ask first. |
| "These imports are in the wrong order" | That's the formatter's job, not yours. |
| "Let me use a better library for this" | Are built-in features sufficient? If yes, don't add a dependency. |
| "I should add a README section" | The user didn't ask for docs. Don't add them. |
| "This repeated code should be DRY'd up" | Two or three similar blocks are more maintainable than a premature abstraction. |

## Pattern Recognition Cheatsheet

When scanning your own diff, check for these patterns in order:

| Pattern | What it looks like | Action |
|---------|--------------------|--------|
| Adjacent edit | Two unrelated functions changed in one file | Revert all but the requested one |
| New file unprompted | A file the user did not name | Delete the file; inline the code if possible |
| New directory | `utils/`, `helpers/`, etc. created | Move the code back; do not introduce taxonomies |
| New dependency | `package.json` / `requirements.txt` modified | Revert; ask the user before re-adding |
| New abstraction | An interface, base class, factory you added | Inline the implementation directly |
| New test file | Tests the user did not request | Discard or move to a separate proposal |
| New doc/comment block | More than a single inline comment | Remove unless explicitly asked for docs |
| Cross-file rename | A symbol renamed and propagated | Revert; rename only when the user asks |

If any pattern matches and the user did not ask for it, you have crossed
into grinding territory. Apply the L1/L2/L3/L4 recovery (see `references/workflow.md`).
