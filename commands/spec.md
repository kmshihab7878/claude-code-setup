# Specification

Create an executable specification with clear acceptance criteria.

## Instructions

Use `$ARGUMENTS` to describe the feature or system to specify.

### Section 1: Overview
- Feature name and one-line description
- Problem statement (what problem does this solve?)
- Target users and use cases

### Section 2: Requirements
#### Functional Requirements
- FR-1: [requirement with testable criteria]
- FR-2: ...

#### Non-Functional Requirements
- NFR-1: Performance targets (response time, throughput)
- NFR-2: Security requirements
- NFR-3: Scalability expectations

### Section 3: Acceptance Criteria (Given/When/Then)
```gherkin
Feature: [Feature Name]

  Scenario: [Happy path]
    Given [precondition]
    When [action]
    Then [expected result]

  Scenario: [Error case]
    Given [precondition]
    When [invalid action]
    Then [error handling]
```

### Section 4: API Contract (if applicable)
- Endpoints with request/response schemas
- Error codes and their meanings

### Section 5: Data Model
- Entities and relationships
- Field definitions with types and constraints

### Section 6: Out of Scope
- Explicitly list what is NOT included
- Deferred to future iterations

Output a complete specification that developers can implement against and QA can test against.
