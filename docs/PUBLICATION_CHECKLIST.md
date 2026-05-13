# Publication Checklist

Run through this checklist before publishing this repository — or any fork — to a public location.

The list codifies the maximum-safety scrub completed in commit `3ccc6a7` and is meant to be repeated whenever new content lands.

---

## 1. Working tree — banned-term gate

```bash
bash scripts/check-public-safety.sh
```

Must print `Public-safety check passed.` Any failure must be fixed before continuing.

## 2. Secret scanners

```bash
gitleaks detect --no-banner --redact --source .
trivy fs --scanners secret .
```

Both must report zero findings. If a "secret" is a placeholder, replace it with an obvious sentinel (`<your-api-key>`, `placeholder-not-real`).

## 3. Forward-tree free-form sweep

The orchestrator runs the canonical banned-term regex plus the broader free-form check (path leaks, env files, `.DS_Store`, stale renamed paths). Run it instead of hand-crafting greps:

```bash
bash scripts/audit-public-readiness.sh --quick
```

Pattern definitions live in `scripts/check-public-safety.sh` (gate) and `scripts/audit-public-readiness.sh` (orchestrator). Both use character-class regex wrappers so the gate's own patterns don't appear as bare literals anywhere a fresh contributor or future history rewrite could neutralize.

Allowed remaining hits:

- `gmail` as MCP service name (not a real address)
- `/Users/me/...` placeholder in third-party docs
- `/Users/<user>` / `/Users/redacted-username` already-redacted forms
- `@gmail.com` with zero-width-space wrapper used in incident docs

Anything else: fix.

## 4. History scan

```bash
# Working tree + history secret scan
gitleaks detect --no-banner --redact

# Full orchestrator (drops the --quick flag — exercises the cross-history blob grep)
bash scripts/audit-public-readiness.sh
```

The orchestrator's history-blob grep uses the same character-class regex as the forward-tree pass; it greps every reachable commit in `$(git rev-list --all)`. Backup tags keep pre-scrub commits reachable locally and will trigger hits — that's expected. Delete the backup tags once you're certain the rewrite is good (`git tag -d pre-public-scrub-*  pre-handle-rewrite-*`).

If history contains personally-identifying terms, decide:

- **Accept** — orphaned SHAs expire on GitHub-side garbage collection (~90 days).
- **Rewrite** — `git filter-repo --replace-text replacements.txt --replace-message replacements.txt`, then force-push only the affected branch (never main without coordination). Backup tag first.

## 5. Validation suite

```bash
bash scripts/validate.sh
```

Must end with `fail=0`. Warnings are acceptable when documented.

## 6. Untracked / ignored files

```bash
git status --ignored --short
find . -path ./.git -prune -o -name ".DS_Store" -print
find . -path ./.git -prune -o -name "*.env" -print
```

`.DS_Store`, `*.env`, session records, memory exports must be gitignored, never staged.

## 7. Remote + branch protection

Before pushing:

- Confirm the target remote: `git remote -v`
- Confirm branch isn't `main` for new force-pushes
- If branch protection on `main` is enabled, force-push will be rejected — that's the intended behavior

## 8. Push and PR

```bash
git push -u origin <branch>            # or --force-with-lease for rewrites
gh pr create --base main --head <branch> --title "..." --body "..."
```

## 9. Post-publication

If history was rewritten:

- Inform collaborators to re-clone or rebase their working copies.
- Note the SHA-orphan window in the PR description so direct-SHA URLs don't surprise readers.
- Consider asking GitHub Support to expire orphaned commits sooner than the default ~90 days for high-sensitivity rewrites.

## 10. CI gates

GitHub Actions in `.github/workflows/public-safety.yml` re-runs steps 1, 2, and 5 on every PR. A red CI run blocks merge. Don't disable the workflow to ship — fix the leak.

---

## Backup tags

Before any history rewrite:

```bash
git tag "pre-rewrite-$(date +%Y%m%d-%H%M%S)"
```

Backup tags are local-only by default. Push them only if you intend the old history to be preserved on the remote — usually you don't.

## When to rotate credentials

If at any point in history a real credential was committed, **rotate it**, regardless of whether the history rewrite removed the visible string. The credential was on disk somewhere accessible to anyone who fetched the repo before the rewrite. History rewrite ≠ credential rotation.
