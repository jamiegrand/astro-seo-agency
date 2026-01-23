---
description: SEO tools - wins, gaps, ROI, refresh, history, impact, keywords, links
argument-hint: "[wins|gaps|roi|refresh|history|impact|keywords|links] [args]"
---

# /seo - SEO & Analytics Tools

Run `/seo <subcommand>` or use the direct command.

## Subcommands

| Subcommand | Direct Command | Description | Requires |
|------------|----------------|-------------|----------|
| `wins` | `/seo-wins` | Find GSC quick wins (position 4-15) | GSC |
| `gaps` | `/seo-gaps` | Find content opportunities | GSC |
| `roi` | `/seo-roi` | Analyze content performance | GA + GSC |
| `refresh` | `/seo-refresh` | Find declining pages | GSC |
| `history [page]` | `/seo-history` | View audit score trends | — |
| `impact [#]` | `/seo-impact` | Measure before/after effect | GA + GSC |
| `keywords [action]` | `/seo-keywords` | Manage keyword cache | — |
| `links [view]` | `/seo-links` | Analyze internal linking structure | DB v4 |

## Routing

**If a subcommand is provided:** Read and execute the corresponding implementation file:
- `wins` → Read `commands/seo-wins.md` and execute
- `gaps` → Read `commands/seo-gaps.md` and execute
- `roi` → Read `commands/seo-roi.md` and execute
- `refresh` → Read `commands/seo-refresh.md` and execute
- `history` → Read `commands/seo-history.md` and execute
- `impact` → Read `commands/seo-impact.md` and execute
- `keywords` → Read `commands/seo-keywords.md` and execute
- `links` → Read `commands/seo-links.md` and execute

**If no subcommand:** Display the table above and ask what they'd like to do.

## Examples

```bash
/seo              # Show this help
/seo wins         # Execute seo-wins.md
/seo gaps         # Execute seo-gaps.md
/seo history /blog/my-post  # Execute seo-history.md with argument
/seo links        # Show internal link analysis
/seo links orphans   # Find orphan pages
```
