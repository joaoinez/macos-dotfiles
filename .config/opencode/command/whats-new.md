---
description: See what's new since a specific version
model: github-copilot/gemini-3-flash-preview
---

Run `opencode-whats-new.sh` to fetch release notes between the last
checked version and the current version.
Note that this script is in the `$PATH`.

Summarize all the changes made to the TUI based on the release notes.
Focus mostly on new features and skip the bug fixes, unless they are critical.
Format the output like this:

```txt
Features:
- Some feature ...
- Some other feature ...
Bug Fixes:
- Some critical bug fix ...
```

Don't output anything else apart from this summary.
