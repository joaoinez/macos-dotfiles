---
description: see what's new since a specific version
model: github-copilot/gemini-3-flash-preview
---

First, run `opencode --version` to get the current version.

Then, run this command to fetch the release notes between $1 (the oldest version)
and the current version:

```bash
gh api repos/anomalyco/opencode/releases --jq '[.[] | {tag: .tag_name, body: .body}] | map(select(.tag >= "OLDEST" and .tag <= "CURRENT"))'
```

Replace `OLDEST` with $1 and `CURRENT` with the version from `opencode --version`.
But don't forget to prefix the versions with `v`, so it looks like `v1.0.0`.

Summarize all the changes made to the TUI based on the release notes.

Don't output anything else apart from this summary.
