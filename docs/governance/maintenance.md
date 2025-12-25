# Maintenance guide

This repo is designed to be easy to maintain with simple rules.

## Folder rules

- `docs/101/`: Introductory material (assume no prior context)
- `docs/howtos/`: Task-oriented guides (step-by-step)
- `docs/advanced/`: Deep dives and operational practices
- `snippets/`: Copy/paste examples with minimal context

## Writing guidelines

- One topic per page.
- Prefer short sections and concrete examples.
- Put site-specific caveats near the top.
- Use placeholders like `YOURHLQ`, `YOURUSER`, `YOURCLUSTER`.

## Keeping links healthy

- When adding a new page, link it from `README.md` and/or `docs/index.md`.
- Use relative links.

## Release cadence (optional)

- Use tags like `v0.1`, `v0.2` for milestones.
- Keep a short `CHANGELOG.md` if you want to track notable additions.
