local map = vim.keymap.set

-- ── Aux ─────────────────────────────────────────────────────────────────────
map("i", "jj", "<Esc>", { desc = "Escape" })
map("n", "x",  '"_x',   { desc = "Delete char (no yank)" })
map("n", "dw", '"_db',  { desc = "Delete word back (no yank)" })

-- ── Save / Quit ─────────────────────────────────────────────────────────────
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })
map("n", "<leader>o", "<cmd>w<cr><cmd>source %<cr>", { desc = "Save & source" })

-- ── Search highlight ────────────────────────────────────────────────────────
map("n", "<leader>ur", "<cmd>nohlsearch<cr>", { desc = "Clear hlsearch" })

-- ── Panes / Windows ─────────────────────────────────────────────────────────
map("n", "ss", "<cmd>split<cr>",  { desc = "Split horizontal" })
map("n", "sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<space>", "<C-w>w", { desc = "Next window" })
map("n", "<C-l>",   "<C-w>w", { desc = "Next window" })
map("n", "<C-h>",   "<C-w>W", { desc = "Prev window" })
map("n", "<C-w><Left>",  "<C-w><", { desc = "Resize left" })
map("n", "<C-w><Right>", "<C-w>>", { desc = "Resize right" })
map("n", "<C-w><Up>",    "<C-w>+", { desc = "Resize up" })
map("n", "<C-w><Down>",  "<C-w>-", { desc = "Resize down" })

-- ── Buffers ─────────────────────────────────────────────────────────────────
map("n", "gn", "<cmd>bnext<cr>",     { desc = "Next buffer" })
map("n", "gp", "<cmd>bprevious<cr>", { desc = "Prev buffer" })

-- ── Tabs ────────────────────────────────────────────────────────────────────
map("n", "te", "<cmd>tabnew<cr>",   { desc = "New tab" })
map("n", "tq", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<Tab>",   "<cmd>tabnext<cr>",     { desc = "Next tab" })
map("n", "<S-Tab>", "<cmd>tabprevious<cr>", { desc = "Prev tab" })
map("n", "<C-,>",   "<cmd>tabmove 0<cr>",   { desc = "Move tab to start" })
map("n", "<C-.>",   "<cmd>tabmove +1<cr>",  { desc = "Move tab right" })

-- ── Diagnostics ─────────────────────────────────────────────────────────────
map("n", "<C-j>", function() vim.diagnostic.jump({ count =  1, float = true }) end,
  { desc = "Next diagnostic" })
map("n", "<C-k>", function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = "Prev diagnostic" })

-- ── Hover (safety net so K never falls through to keywordprg=pydoc/man) ─────
-- Buffer-local K is also set in LspAttach when an LSP is attached; this global
-- mapping covers buffers without LSP and prevents the default `K` behaviour.
map("n", "K", function()
  local clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/hover" })
  if next(clients) then
    vim.lsp.buf.hover()
  else
    vim.notify("No LSP hover provider for this buffer", vim.log.levels.INFO)
  end
end, { desc = "Hover" })

-- ── File explorer (built-in netrw — replaces neo-tree / file_browser) ───────
map("n", "sf", "<cmd>Explore<cr>", { desc = "Explore (netrw)" })

-- ── Visual ──────────────────────────────────────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up" })
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ── Centred scroll ──────────────────────────────────────────────────────────
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
