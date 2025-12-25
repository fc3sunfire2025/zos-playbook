# Contributing

Thanks for helping improve the z/OS Playbook.

## Quick start

1. Create a branch from `main`
2. Make your edits (docs and snippets are Markdown/text)
3. Open a pull request (PR)

## What we’re looking for

- Clear, task-focused how-to guides
- Small, reusable code snippets with context and caveats
- 101 explanations that assume minimal prior knowledge
- Advanced guidance that is actionable and safe

## Content guidelines

- Prefer placeholders like `YOURHLQ`, `YOURUSER`, `YOURCLASS`.
- Do not include site-identifying details (hostnames, IPs, real dataset HLQs, internal ticket numbers).
- Do not include secrets (passwords, tokens, keys).
- Put **safety notes** and **prerequisites** near the top.

## Structure

- `docs/101/` → introductory material
- `docs/howtos/` → step-by-step guides
- `docs/advanced/` → deep dives
- `snippets/` → minimal copy/paste examples

## PR checklist

- Links work (relative links preferred)
- New pages are linked from `README.md` and/or `docs/index.md`
- Snippets include brief purpose + placeholders
- No sensitive data

If you’re new to GitHub, see `docs/governance/maintenance.md` for repo upkeep patterns.
