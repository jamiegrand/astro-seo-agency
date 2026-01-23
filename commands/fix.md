---
description: Fix issues - single, batch, or specific
argument-hint: "[count|#issue]"
---

# /fix - Issue Resolution

Fix one issue, multiple issues, or a specific issue.

## Usage

| Command | Routes To | Description |
|---------|-----------|-------------|
| `/fix` | `fix-next.md` | Fix highest-priority issue |
| `/fix 5` | `fix-batch.md` | Fix top 5 issues in sequence |
| `/fix #42` | `fix-next.md` | Fix specific issue #42 |

## Routing

**No argument or `#number`:** Read `commands/fix-next.md` and execute
- Pass issue number if provided (e.g., #42)

**Numeric argument (e.g., `5`):** Read `commands/fix-batch.md` and execute
- Pass count as argument

## Examples

```bash
/fix          # Single highest-priority issue
/fix 3        # Batch fix top 3 issues
/fix 10       # Batch fix top 10 issues
/fix #42      # Fix specific issue #42
/fix #123     # Fix specific issue #123
```
