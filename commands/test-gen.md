# Test Generation

Generate comprehensive tests for the specified code.

## Instructions

Use `$ARGUMENTS` to identify the target (file, function, class, or module).

### Test Categories to Generate

1. **Happy Path Tests**
   - Normal expected inputs and outputs
   - Common use cases
   - Typical user workflows

2. **Edge Case Tests**
   - Empty inputs (null, undefined, empty string, empty array)
   - Boundary values (0, -1, MAX_INT, empty, single item)
   - Unicode and special characters
   - Very large inputs

3. **Error Case Tests**
   - Invalid input types
   - Missing required fields
   - Network/IO failures (mocked)
   - Timeout scenarios
   - Permission/auth failures

4. **Property-Based Tests** (where applicable)
   - Invariants that should always hold
   - Round-trip properties (encode/decode)
   - Commutativity, associativity where expected

### Framework Selection
- Python: pytest with pytest-cov, hypothesis for property tests
- TypeScript/JavaScript: vitest or jest with testing-library
- Use mocks for external dependencies

### Output
- Complete test file(s) ready to run
- Coverage analysis of what's tested
- List of any untestable code (suggest refactoring)
