# z/OS Playbook

Everything z/OS for all levels — a practical, maintainable reference repo for mainframers.

## Read this first

- **Review all code before execution.** Don’t run jobs, commands, or scripts you don’t fully understand.
- **Test in non-production first.** Prefer a sandbox LPAR or equivalent controlled environment.
- **Follow your site security & change control.** Ensure everything adheres to your organization’s policies.

Full details: [docs/DISCLAIMER.md](docs/DISCLAIMER.md)

## How this repo is organized

- 101 (new to z/OS): [docs/101/](docs/101/)
- How-tos (task focused): [docs/howtos/](docs/howtos/)
- Advanced (deep dives): [docs/advanced/](docs/advanced/)
- Snippets (copy/paste with context): [snippets/](snippets/)
- Maintenance notes: [docs/governance/maintenance.md](docs/governance/maintenance.md)

## Start here

- Docs home: [docs/index.md](docs/index.md)
- Getting oriented: [docs/101/getting-oriented.md](docs/101/getting-oriented.md)
- JCL snippet index: [snippets/jcl/README.md](snippets/jcl/README.md)

## Adding content (simple workflow)

If you’re new to GitHub, this is the easiest way to keep the repo tidy:

1. Create a new branch
2. Add or edit Markdown/snippets
3. Open a pull request (PR)
4. Merge to `main`

See: [CONTRIBUTING.md](CONTRIBUTING.md)

## Suggested content conventions

- Use placeholders: `YOURHLQ`, `YOURUSER`, `YOURCLASS`, `YOURPROC`
- Explain prerequisites and risks near the top
- Keep each page focused on one topic
- Avoid committing site-identifying details or sensitive data

## Repo maintenance tips

- Link new pages from [docs/index.md](docs/index.md) and/or this README.
- Keep snippet files small; prefer one concept per file.
- Use Issues for requests and corrections; PRs for changes.

## License

No license is included yet. If you plan to share publicly, choose a license that matches your intent (e.g., MIT/Apache-2.0) and add it as `LICENSE`.
