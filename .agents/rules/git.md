---
trigger: always_on
---

# Git Workflow Rules

Commit messages:

Use:

type(scope): description

Examples:

feat(auth): add login API

fix(cart): resolve quantity bug

Before commit:

Check:

- Build passes.
- Tests pass.
- No debug code.

Never:

- Commit secrets.
- Commit generated files.
- Force push without confirmation.
