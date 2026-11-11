# Dot file setup

Install with:

```shell
./install.sh
```

Links bash and vim files, and prepends the local fish functions directory to Fish's function path.

Personal Codex skills live in `skills/`. The installer links each skill into
`~/.agents/skills/`, so edits remain in this repository and Codex discovers them
across projects. To install only the skill links, run:

```shell
bash scripts/link-skills.sh
```

Existing directories or links to another location are preserved and reported as
conflicts. Skill dependencies such as `node_modules/` are not tracked; install
them from the skill's dependency manifest when needed.
