# 2026-05-05 — History rewrite #2: PII + cross-repo path scrub

**Type:** Privacy remediation · destructive history rewrite · forward-state + history clean
**Status:** Forward state clean. Public origin force-pushed. GitHub-cache GC pending.
**Owner:** Repository owner

## What triggered this

Operator invoked `/ultraplan` security audit ("ensure no leak whatsoever") on 2026-05-05. Audit discovered:

1. **Operator OS username** (`<scrubbed>`) embedded in 16 tracked files: 2 audit-doc absolute paths + 14 yaml `author:` fields.
2. **Second-private-project file paths** (`~/<private-project>/...`) leaked across 25 lines in `docs/SECURITY_PLAYBOOK.md` — same exposure class as the 2026-05-03 incident.
3. **Operator's real email** (`<scrubbed>@example-host.invalid`) embedded in the **author metadata of every commit** (32+ commits) — discovered during the all-history grep. NOT visible to forward-state file scans.
4. **Operator's full name** (`Khaled <surname>`) still present in older commits' diffs as deletion lines from prior PII sweeps (29 blobs + 2 commit messages).

Forward-state fix landed in `944f9fe` (now orphaned). This decision covers the destructive history rewrite that scrubs all four classes from every commit.

## What was done

Single-pass `git filter-repo` rewrite with:

1. **Mailmap** — rewrites every commit's author/committer to:
   `kmshihab7878 <kmshihab7878@users.noreply.github.com>` (GitHub-issued privacy-preserving address).
2. **`--replace-text`** with patterns:
   - operator full name → `Repository owner`
   - operator OS username → `redacted-username`
   - operator email-prefix → `redacted-email`
   - any `@example-host.invalid` → `@example.invalid` (catch-all)
   - `~/<private-project>` → `~/your-project`
3. **`--replace-message`** with the same pattern set so commit-message bodies are scrubbed.
4. **Force-push** to `origin/main`.
5. **Local repo git config** updated to use the noreply email going forward (`git config --local user.email kmshihab7878@users.noreply.github.com`). Global git config NOT touched — that's an operator decision per repo.

## Verification

Fresh `git clone` verification (post-push, run on 2026-05-05 22:03):

| Pattern | Blobs | Messages | Author/Committer |
|---------|-------|----------|-------------------|
| Full name | 0 | 0 | 0 |
| OS username | 0 | 0 | 0 |
| Email-prefix | 0 | 0 | 0 |
| `@example-host.invalid` | 0 | 0 | 0 |
| `~/<private-project>` | 0 | 0 | 0 |
| Public handle (allowed) | 68 | (LICENSE / README / ELITE-OPS docs / decisions logs) |

- gitleaks: 0 leaks across all 26 commits / 8.18 MB
- `make validate`: pass=25 warn=3 fail=0 (3 warnings are pre-existing tech debt unrelated to PII)
- All commit authors now appear as `kmshihab7878 <kmshihab7878@users.noreply.github.com>`

## Backup

Pre-rewrite snapshot at:
- `~/Backups/claude-code-setup-pre-history-rewrite-2-20260505-225104/` (working tree)
- `~/Backups/claude-code-setup-pre-history-rewrite-2-20260505-225104.git/` (mirror)

The earlier 2026-05-03 backup is also still on disk:
- `~/Backups/claude-code-setup-pre-history-rewrite-20260503-211059/`
- `~/Backups/claude-code-setup-pre-history-rewrite-20260503-211059.git/`

**Both contain the pre-scrub sensitive content.** Recommended handling:

1. **Encrypt** with gpg or a passphrase-protected zip:
   ```bash
   cd ~/Backups
   for d in claude-code-setup-pre-history-rewrite*; do
     tar czf "$d.tgz" "$d" && rm -rf "$d"
     gpg -c "$d.tgz"  # interactive passphrase
     rm "$d.tgz"
   done
   ```
2. **Or delete** after 30+ days of confidence the rewrite landed correctly:
   ```bash
   rm -rf ~/Backups/claude-code-setup-pre-history-rewrite*
   ```

## Residual exposure (after this rewrite)

| Surface | Status | Action |
|---------|--------|--------|
| Fresh clones of the repo | CLEAN | None — verified |
| `git log -p` / `git log --format` on a fresh clone | CLEAN | None |
| All branches' tip state + author metadata | CLEAN | None |
| GitHub commit URLs by SHA — current orphaned set | Still resolves until GitHub GC | Send updated Support email (template below) |
| `refs/pull/{1..7}/head` for closed PRs | Pinned to old SHAs | Same — Support GC handles |
| External caches (search engines, archive.org, anyone who cloned before 2026-05-05 22:03 GMT+3) | Out of repo's control | Cannot remediate |
| Operator's GLOBAL git config still has personal Gmail | Operator-controlled | Optional: `git config --global user.email kmshihab7878@users.noreply.github.com` to default ALL repos to the noreply email |

## Orphaned SHAs (for GitHub Support ticket)

Both rewrites combined have orphaned the following from `main`:

**From 2026-05-03 rewrite (already documented):**
- Pre-rewrite tip: `8482de66` (and ancestor commits via filter-repo's history rewriting)
- PR refs: `refs/pull/1/head` through `refs/pull/4/head` pin pre-rewrite SHAs

**From 2026-05-05 rewrite (new):**
- Pre-rewrite tip: `944f9fe3d5734be00e25900be309e20f2883c248` (the forward-state security commit)
- All ancestors of `944f9fe` via filter-repo

## GitHub Support email — UPDATED template

> **To:** support@github.com (or via https://support.github.com/contact)
> **Subject:** Sensitive data removal — request expedited GC after second history rewrite
>
> Hi GitHub Support,
>
> I've performed two `git filter-repo` history rewrites on a public repository, with corresponding force-pushes:
> - 2026-05-03: removed a private skill directory + brand vocabulary
> - 2026-05-05: scrubbed operator PII (real name, OS username, personal email in commit author metadata) and second private-project file paths
>
> Fresh clones are now completely clean. Verified via `git log --all -p`, `git log --all --format='%an %ae'`, and `gitleaks`. Zero matches across blobs, messages, or author/committer metadata.
>
> However, orphaned commits remain cached on github.com and resolve via direct `/commit/<sha>` URLs.
>
> Repo: https://github.com/kmshihab7878/claude-code-setup
> Affected PR refs (still pin pre-rewrite SHAs): #1 through #7 — `refs/pull/{1..7}/head`
> Affected dangling commits include (non-exhaustive): `8482de66...`, `944f9fe3...`, plus ancestors.
>
> Please run garbage collection / expire the orphaned objects so they no longer resolve via `/commit/SHA` URLs. I am the repository owner and the only author of all rewritten commits.
>
> Forks: 0. No coordination required with downstream users.
>
> Thank you.

## Operator follow-up checklist

- [ ] Send GitHub Support email above
- [ ] Decide whether to encrypt or delete the two pre-rewrite backups in `~/Backups/`
- [ ] Decide whether to update GLOBAL git config: `git config --global user.email kmshihab7878@users.noreply.github.com`
- [ ] After GitHub confirms GC, re-test orphaned SHA URLs with `curl -s -o /dev/null -w "%{http_code}" https://github.com/kmshihab7878/claude-code-setup/commit/944f9fe` — expect 404
- [ ] Schedule a follow-up audit in 30 days to verify no regression

## What this document does NOT contain

For privacy: no real name, no email, no OS username, no private-project name. Pre-rewrite backups have the originals if needed for forensic reference only.
