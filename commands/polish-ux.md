---
description: "UX-only polish pass. No core logic changes. Focus on microstates, copy, accessibility, visual coherence, and perceived quality."
---

# /polish-ux — UX Polish Mode

Do not change core logic unless it is broken. Focus exclusively on perceived quality.

## Polish Checklist

### Loading States
- [ ] Every async operation has a visible loading indicator
- [ ] Loading states feel intentional, not janky
- [ ] Skeleton screens match the shape of real content
- [ ] No layout shift when content loads

### Empty States
- [ ] Empty states teach the user what to do next
- [ ] Empty states have appropriate visual weight (not just text)
- [ ] Empty states include a primary action when applicable

### Error States
- [ ] Errors are human-readable, not stack traces
- [ ] Error states offer a recovery action
- [ ] Network errors have retry affordance
- [ ] Form validation errors are inline and specific

### Hover & Focus
- [ ] Interactive elements have hover states
- [ ] Focus-visible rings are consistent across the app
- [ ] Tab order follows visual reading order
- [ ] No focus traps in modals or dropdowns

### Copy & Labels
- [ ] Button labels describe the action, not just "Submit" or "OK"
- [ ] Confirmation dialogs explain what will happen
- [ ] Toast messages are specific and helpful
- [ ] Placeholder text is useful, not redundant with the label

### Visual Coherence
- [ ] Spacing rhythm is consistent (uses the design system's scale)
- [ ] Typography hierarchy is clear (no competing headings)
- [ ] Color usage is restrained and purposeful
- [ ] Icons are from the same family, same size, same stroke weight

### Accessibility
- [ ] Color contrast meets WCAG AA
- [ ] Images have meaningful alt text
- [ ] Form inputs have associated labels
- [ ] Screen reader flow makes sense without visual context

## Rules
- Use the design language already in the repo
- Do not introduce new UI libraries or components unless absolutely necessary
- Keep changes scoped to UX improvements
- If a logic fix is needed to make the UX work, note it as a finding but keep it minimal

## Target

$ARGUMENTS
