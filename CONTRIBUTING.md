# Contributing to Astro SEO Agency

Thank you for your interest in contributing! This guide will help you get started.

## Ways to Contribute

### 🐛 Bug Reports

Found a bug? Please open an issue with:
- Command that caused the issue
- Expected behavior
- Actual behavior
- Your environment (Astro version, Node version)

### 💡 Feature Requests

Have an idea? Open an issue describing:
- The problem you're trying to solve
- Your proposed solution
- Any alternatives you've considered

### 🔧 Code Contributions

Want to add or fix something? Great!

## Development Setup

```bash
# 1. Fork and clone the repository
git clone https://github.com/YOUR-USERNAME/astro-seo-agency.git
cd astro-seo-agency

# 2. Create a test Astro project
npm create astro@latest test-project
cd test-project

# 3. Install the plugin locally
bash ../install.sh

# 4. Test your changes
# Open test-project in Claude Code and try commands
```

## Project Structure

```
astro-seo-agency/
├── commands/           # Slash command definitions
│   ├── start.md
│   ├── fix-next.md
│   └── ...
├── agents/             # Agent role definitions
│   ├── seo-analyst.md
│   ├── astro-maintainer.md
│   └── content-strategist.md
├── prompts/            # Interactive prompts
│   ├── setup.md
│   └── brownfield.md
├── templates/          # File templates
├── install.sh          # Installation script
├── plugin.json         # Plugin manifest
└── README.md
```

## Command File Format

Commands use markdown with YAML frontmatter:

```markdown
---
description: Brief description for /help
argument-hint: "[optional-arg]"
---

# Command Name

## Step 1: What Claude Should Do

Describe the step in detail...

### Substep

More details...

## Step 2: Next Step

Continue the workflow...
```

### Best Practices for Commands

1. **Be explicit** - Claude should know exactly what to do
2. **Include examples** - Show expected outputs
3. **Handle errors** - What if something fails?
4. **Provide options** - Let users choose next steps
5. **Use consistent formatting** - Match existing commands

## Testing Changes

Before submitting:

1. **Test in a real Astro project**
   ```bash
   /your-command
   ```

2. **Test error cases**
   - What if files don't exist?
   - What if analytics aren't configured?
   - What if the build fails?

3. **Test the full workflow**
   ```bash
   /start
   /fix-next
   /pause
   /resume
   ```

## Pull Request Process

1. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**

3. **Test thoroughly**

4. **Update documentation** if needed

5. **Submit PR** with:
   - Clear description of changes
   - Screenshots/examples if applicable
   - Note any breaking changes

## Code Style

### Markdown Commands

- Use ATX-style headers (`#`, `##`, `###`)
- Use fenced code blocks with language hints
- Use tables for structured data
- Include emoji sparingly for visual hierarchy

### Shell Scripts

- Use `set -e` for error handling
- Add comments for complex logic
- Use color output for user feedback
- Test on both macOS and Linux

## Commit Messages

Use conventional commits:

```
feat(commands): add /competitor command
fix(start): handle missing GSC config
docs(readme): clarify installation steps
chore(deps): update template versions
```

## Questions?

- Open an issue for general questions
- Tag maintainers for urgent items

Thank you for contributing! 🎉
