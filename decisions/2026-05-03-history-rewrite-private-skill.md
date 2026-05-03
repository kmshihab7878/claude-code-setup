# 2026-05-03 — History rewrite: private design-system skill scrubbed

**Type:** Privacy incident · forward-state remediation
**Status:** Forward state clean. GitHub-cache GC pending.
**Owner:** Repository owner

## What happened

A private product's design-language skill (full design tokens, brand vocabulary, page paths, identity decisions) was committed to the **public** `claude-code-setup` repo in PR #1 on 2026-04-16, intended as a Hue-generated child skill. It remained in the public repo until 2026-05-03.

Sensitive strings have been scrubbed from this document; refer to the local pre-rewrite backup for the original content if needed.

## Detection

Surfaced during AI OS integration session when the operator noticed the directory name match a private product. Two follow-up questions confirmed the privacy concern, leading to immediate remediation.

## Forward-state fix (PR #3)

- Removed the entire skill directory
- Edited 3 doc files to remove name references
- Added `.gitignore` guard to prevent re-add
- Updated CLAUDE.md skill count

## History rewrite

Used `git filter-repo`:

1. **Pass 1 — `--path <skill-dir> --invert-paths --force`**: removed the directory from every commit on every branch.
2. **Pass 2 — `--replace-text` with patterns**: scrubbed sensitive product/brand strings from every commit's blob diffs.
3. **Pass 3 — `--replace-message`**: scrubbed sensitive strings from every commit message.
4. **Branch rename**: ref label that contained the product name renamed to `chore/remove-private-skill`.
5. **Force-push** all 4 branches (`main`, `ai-os-nate-warp-socraticode-setup`, `chore/pii-sweep`, `chore/remove-private-skill`).
6. **PR title scrub**: edited PR #1, #2, #3, #4 titles to remove the private product name.

Verified via fresh clone: zero matches across all sensitive patterns in blobs, messages, and tree contents on every branch.

## Backup

Pre-rewrite snapshot at `~/Backups/claude-code-setup-pre-history-rewrite-20260503-211059/` (working tree) and `~/Backups/claude-code-setup-pre-history-rewrite-20260503-211059.git/` (mirror). These contain the **original sensitive content** — keep them encrypted, never push them, and delete once you're confident the rewrite landed correctly (suggested: 30+ days after GitHub Support GC confirms).

## Residual exposure

| Surface | Status | Action |
|---------|--------|--------|
| Fresh clones of the repo | CLEAN | None — verified |
| `git log -p` on a fresh clone | CLEAN | None |
| All 4 branches' tip state | CLEAN | None |
| GitHub commit URLs by SHA | Still resolves until GitHub GC | File a GitHub Support ticket (template below). Auto-GC takes 30+ days otherwise. |
| `refs/pull/N/head` for the 4 PRs | Pinned to old SHAs | Same — GitHub Support GC handles this. |
| External caches (search engines, archive.org, anyone who cloned before 2026-05-03 22:00 GMT+3) | Out of repo's control | Cannot remediate. |
| Forks | 0 — verified before rewrite | None |

## Operator next steps

1. Send the GitHub Support email below.
2. After GitHub confirms GC, re-test orphaned SHA URLs to confirm they 404.
3. Consider a sweep audit for OTHER private references that may not have been caught — `git log --all -p | less` on the rewritten history; eyeball for any product names, customer names, or internal terminology.
4. After 30+ days of confidence, delete the local backup at `~/Backups/claude-code-setup-pre-history-rewrite-*`.

## GitHub Support email template

> **To:** support@github.com (or via https://support.github.com/contact)
> **Subject:** Sensitive data removal — request expedited GC after force-push history rewrite
>
> Hi GitHub Support,
>
> I've performed a `git filter-repo` history rewrite on a public repository to remove sensitive product information that was accidentally committed. I've force-pushed clean history to all branches. Fresh clones are now clean, but orphaned commits remain cached and accessible via direct SHA URLs.
>
> Repo: https://github.com/kmshihab7878/claude-code-setup
> Affected PR refs: #1, #2, #3, #4 — `refs/pull/{1,2,3,4}/head` still pin pre-rewrite SHAs.
>
> The orphaned commit SHAs are listed in the operator's local incident notes; I can share them privately if you need them, but I'd prefer not to put them in this public ticket.
>
> Please run garbage collection / expire the orphaned objects so they no longer resolve via /commit/SHA URLs.
>
> Forks: 0. No coordination required with downstream users.
>
> Thank you.

## What this document does NOT contain

For privacy: no product name, no brand vocabulary, no design-token specifics, no page paths, no internal terminology. Pre-rewrite backup at `~/Backups/...` has the original content if needed for reference.
