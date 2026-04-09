# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal Neovim 0.12 configuration. Minimal, hand-picked stack — no distro (LazyVim was removed in the 0.12 rewrite, see commit `0cbad87`). Optimized for fast startup, native 0.12 LSP API, and a small surface area.

## Common operations

There is no build, lint, or test pipeline — this is a runtime config.

- `nvim` — load the config; on first run `lazy.nvim` bootstraps itself and installs plugins.
- `:Lazy` — plugin manager UI (sync, update, clean, profile).
- `:Lazy profile` — startup profiling; expect cold start ~30–50 ms.
- `:checkhealth` — diagnose plugin / LSP / treesitter / provider issues.
- `:TSUpdate` — refresh treesitter parsers after editing `lua/plugins/treesitter.lua`. Note: `nvim-treesitter` is on the **`main` branch**, which compiles parsers locally via `tree-sitter` CLI (not prebuilt downloads). The CLI must be on PATH.
- `:TSInstall <lang>` — install a single parser on demand.
- `:ConformInfo` — inspect which formatters `conform.nvim` will run for the current buffer.
- `:Codeium Auth` — authenticate Codeium / Windsurf (after first install).

LSP servers, formatters, and the treesitter CLI are installed manually (no mason). When adding a server in `lua/lsp.lua` or a formatter in `lua/plugins/conform.lua`, install the binary out-of-band:

```
brew install lua-language-server gopls rust-analyzer llvm tree-sitter stylua shfmt
npm i -g vscode-langservers-extracted vtsls basedpyright prettier @fsouza/prettierd
pipx install ruff
```

## Architecture

Boot sequence (`init.lua`) is strictly ordered:

1. `require("options")` — must run first because `vim.g.mapleader` (set to `;`) has to exist before any plugin or keymap is registered.
2. `require("keymaps")` — global, plugin-agnostic mappings.
3. `require("lazy-bootstrap")` — clones `lazy.nvim` into `stdpath("data")` if missing, prepends to rtp.
4. `require("lazy").setup("plugins", ...)` — autoloads every file under `lua/plugins/`. Each file returns a single spec table (or array).
5. `require("lsp")` — runs *after* `lazy.setup` so that `blink.cmp` is on the rtp; capabilities are pulled from `blink.cmp.get_lsp_capabilities()` and set globally via `vim.lsp.config("*", { capabilities = ... })` before `vim.lsp.enable(servers)`.

### Why these files split this way

- `lua/plugins/` is **one file per plugin** by deliberate user preference, not collapsed into a single `plugins.lua`. Keep this layout when adding plugins.
- `lua/plugins/lspconfig.lua` is intentionally a stub — the `nvim-lspconfig` plugin is only needed on the rtp so its `lsp/<name>.lua` server defs are discoverable. All actual config lives in `lua/lsp.lua` using the **0.12 native API** (`vim.lsp.config` + `vim.lsp.enable`), not the legacy `lspconfig.<server>.setup{}` pattern. Don't reintroduce `require("lspconfig")` calls.
- `lua/plugins/treesitter.lua` uses the **`main` branch** of `nvim-treesitter` (not legacy `master`). There is no `configs.setup{}` — parsers are installed via `require("nvim-treesitter").install(parsers)` and highlighting is started by a `FileType` autocmd that calls native `vim.treesitter.start`. Indentation is wired through `indentexpr` per-buffer in the same autocmd. Don't reintroduce `require("nvim-treesitter.configs")`.
- Plugin keymaps belong inside the plugin's own file via lazy `keys = { ... }` (so the plugin loads on first keypress). LSP keymaps are an exception: most are set in `lua/lsp.lua` inside an `LspAttach` autocmd, buffer-local. The single exception is `K` (hover), which is set globally in `lua/keymaps.lua` with a guard that calls `vim.lsp.buf.hover` only when a client is attached — this prevents the default `K` from falling through to `keywordprg` (e.g. `pydoc`) on buffers without LSP.
- Gitsigns keymaps are inside `on_attach` (also buffer-local) for the same reason.

### Leader and keymap conventions

- `<leader>` is `;`. This overrides the built-in repeat-last-`f`/`t` motion — intentional.
- Insert-mode escape is `jj` (not `jk`).
- The full keymap layout is the user's long-standing personal scheme — see git history of `lua/keymaps.lua`, `lua/plugins/fzf.lua`, `lua/plugins/gitsigns.lua`, and the `LspAttach` block in `lua/lsp.lua`. When asked to change a binding, edit the file that owns it; don't centralize.

### What is *not* in this config (and should not be added casually)

- **mason / mason-lspconfig** — removed for startup speed and to keep `~/.local/share/nvim` small. LSP binaries are managed by the OS package manager.
- **lualine / mini.statusline** — replaced by a one-line custom `vim.opt.statusline` in `lua/options.lua`.
- **nvim-cmp** — replaced by `blink.cmp` (Rust core). Don't mix the two.
- **telescope** — replaced by `fzf-lua`. Use `fzf-lua` pickers when adding finder bindings.
- **lspsaga, neo-tree, nvim-tree, dashboard, noice, which-key, indent-blankline** — all intentionally absent. File browsing uses `oil.nvim` (`<leader>fe` for a floating explorer, `<leader>ge` for the same float filtered to git changed/staged files via a `_G._oil_git_filter` allowlist wired into `view_options.is_always_hidden`) plus built-in `netrw` via `sf`. `oil.nvim` runs with `default_file_explorer = false`, so it does **not** hijack directory buffers — netrw stays the default for `sf`.
- **null-ls / none-ls** — replaced by `conform.nvim` (`lua/plugins/conform.lua`). All non-LSP formatting goes through `conform.format({ lsp_format = "fallback" })`, wired into `<leader>fm` in `lua/lsp.lua`. Add new formatters to `formatters_by_ft` in `conform.lua`, not via a parallel plugin.

### Adding a language

1. Add the parser name to the `parsers` table inside `config = function()` in `lua/plugins/treesitter.lua`. After restart, run `:TSInstall <lang>` (or `:TSUpdate`) — `nvim-treesitter` `main` compiles parsers locally and won't auto-install retroactively without a re-fire of the install call.
2. Add the server name to the `servers` table in `lua/lsp.lua` and any per-server overrides via `vim.lsp.config("<name>", { ... })`.
3. If the language needs a non-LSP formatter, add it to `formatters_by_ft` in `lua/plugins/conform.lua`.
4. Install all required binaries manually (see *Common operations* above).

## Git workflow

- Default branch is `master`.
- Commit messages follow Conventional Commits style (`feat:`, `fix:`, `refactor:`, `docs:`) — see `git log` for examples.
- The repo is consumed as a submodule of `~/Projects/dotfiles` (`.config/nvim`), so after pushing here you may want to bump the submodule pointer in dotfiles.
