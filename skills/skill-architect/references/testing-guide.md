# Skill Testing Guide

Three-tier testing methodology for Claude Code skills.

## Tier 1: Triggering Tests

Verify the skill activates for correct prompts and stays dormant for irrelevant ones.

### Positive Triggers (should activate)

Write 3-5 prompts that MUST trigger your skill. Test each by starting a new conversation and entering the prompt.

**What to verify**:
- Skill appears in Claude's reasoning/tool selection
- Skill content influences the response
- Response quality is noticeably different from a generic response

**Example for a `testing-methodology` skill**:
```
"Write unit tests for this function"         -> SHOULD trigger
"What testing strategy should I use?"        -> SHOULD trigger
"Help me set up pytest for this project"     -> SHOULD trigger
```

**Expected pass rate**: 80%+ of positive triggers should activate the skill.

### Negative Triggers (should NOT activate)

Write 3-5 prompts that must NOT trigger your skill.

**Example**:
```
"Fix this bug in my code"                    -> should NOT trigger
"Explain how this function works"            -> should NOT trigger
"What's the weather today?"                  -> should NOT trigger
```

### Edge Cases

Prompts that are ambiguous or near the boundary:

```
"Review my test file" -> may or may not trigger (acceptable either way)
"Is this code testable?" -> borderline (should lean toward triggering)
```

**Tuning**: If triggering is too broad, narrow the description's first sentence. If too narrow, add more keyword coverage.

## Tier 2: Functional Tests

Verify the skill produces correct, useful output when activated.

### Happy Path

Test the primary use case end-to-end:

1. Invoke the skill with a clear, standard request
2. Verify the output follows the skill's prescribed workflow
3. Confirm all critical rules are followed
4. Check output format matches the skill's specification

### Error Path

Test how the skill handles problematic input:

1. Missing context (e.g., no files selected, no project open)
2. Conflicting instructions (e.g., "use React" in a Python project)
3. Incomplete information (e.g., "make it better" with no specifics)

**Expected behavior**: The skill should ask clarifying questions or gracefully degrade, never hallucinate or produce nonsensical output.

### Boundary Cases

Test limits and edge conditions:

1. Very large input (long file, many files)
2. Minimal input (single line, single word)
3. Non-standard project structures
4. Multiple skills potentially applicable

## Tier 3: Performance Comparison

Measure whether the skill improves outcomes versus not having it.

### Setup

1. Select 3 representative tasks the skill should help with
2. For each task, run it twice:
   - **Without skill**: New conversation, standard prompt, no skill loaded
   - **With skill**: New conversation, invoke skill, same task

### Dimensions to Measure

| Dimension | How to Evaluate |
|-----------|----------------|
| **Completeness** | Does the output cover all aspects of the task? (0-5 scale) |
| **Accuracy** | Are the instructions/code correct? (0-5 scale) |
| **Consistency** | Does it follow a predictable structure? (0-5 scale) |
| **Efficiency** | Does it avoid unnecessary steps or tokens? (0-5 scale) |
| **Domain correctness** | Does it follow domain best practices? (0-5 scale) |

### Scoring

```
With-skill score:    __ / 25
Without-skill score: __ / 25
Improvement:         __ points (+__%)
```

**Target**: The with-skill score should be at least 20% higher than the without-skill score. If improvement is under 10%, the skill may not be adding enough value to justify its existence.

## Integration with validate_skill.py

The validation script covers structural and frontmatter correctness (Tier 0). Run it before proceeding to Tier 1-3:

```bash
# Tier 0: Structural validation
python3 ~/.claude/skills/skill-architect/scripts/validate_skill.py <path>

# If Tier 0 passes, proceed to manual testing:
# Tier 1: Open new conversations, test trigger prompts
# Tier 2: Invoke skill, test happy/error/boundary cases
# Tier 3: Compare with/without skill performance
```

Tier 0 is automated. Tiers 1-3 are manual but systematic. Document results for future reference.
