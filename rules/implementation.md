# Implementation Standard Rules

These rules apply to all implementation work regardless of language or framework.

## File Change Contract

For each changed file:
- State why it changed
- Keep edits minimal but complete
- Preserve backward compatibility unless change is necessary

## Prohibited Patterns

Never commit or leave behind:
- `// TODO` markers without an associated issue or ticket
- Mock return values in production code
- Unreachable code branches
- Unfinished event handlers or callbacks
- Silently broken imports
- Naming mismatches between definition and usage
- Partially migrated state models
- `console.log` debugging statements
- Commented-out code blocks longer than 3 lines
- Placeholder strings ("Lorem ipsum", "test", "asdf")

## Required Patterns

Every implementation must:
- Update TypeScript types/interfaces when changing data shape
- Update tests when changing behavior
- Update loading/error/empty states when changing UI flows
- Update API contracts (OpenAPI, GraphQL schema) when changing endpoints
- Handle the sad path, not just the happy path

## Data Model Changes

When modifying schemas or data models:
- Check for downstream consumers before changing field names
- Add database migrations, do not modify existing ones
- Ensure filters, sorting, and search remain coherent after the change
- Preserve audit trail participation if the entity has one

## State Management

Before adding new state:
- Check if the state already exists elsewhere in the app
- Prefer derived state over duplicated state
- Use the existing state management pattern (do not introduce a new one)
- Clean up state on unmount/navigation when appropriate

## Error Handling

Every async operation must:
- Have an error state the user can see
- Provide a recovery action when possible
- Log enough context to debug later
- Not swallow errors silently

## Imports and Dependencies

- Do not add new dependencies if the existing stack can do it
- Do not import from internal modules that are outside the feature's boundary
- Keep import paths consistent with the existing codebase convention
- Remove unused imports before committing
