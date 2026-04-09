# Contributing

This is a personal Neovim configuration. It reflects one person's keymaps, workflow, and taste — it is not a framework or a distro, and there is no roadmap.

**Pull requests that change behavior, add plugins, or rework keymaps will generally not be merged.** Please fork instead — that is what this repo is for.

## What *is* welcome

- **Bug reports** — if something here is straight-up broken (a plugin spec no longer loads, an LSP server fails to start with the documented install command, a typo in `CLAUDE.md`), open an issue with:
  - Neovim version (`nvim --version`)
  - OS
  - Output of `:checkhealth` for the affected subsystem
  - Minimal reproduction steps
- **Security reports** — see [SECURITY.md](./SECURITY.md).

## If you fork

- Keep the `lua/plugins/*.lua` one-file-per-plugin layout if you want `CLAUDE.md` to stay accurate.
- The boot sequence in `init.lua` is load-bearing — read the *Architecture* section of [CLAUDE.md](./CLAUDE.md) before reshuffling it.
- LSP uses the 0.11 native API. Don't reintroduce `require("lspconfig").<server>.setup{}`.

## Commit style

Conventional Commits (`feat:`, `fix:`, `refactor:`, `docs:`, `chore:`). See `git log` for examples.
