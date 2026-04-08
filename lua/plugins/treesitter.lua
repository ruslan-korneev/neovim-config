return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local parsers = {
      "lua", "vim", "vimdoc", "query",
      "python",
      "javascript", "typescript", "tsx",
      "html", "css", "json",
      "go", "gomod", "gosum",
      "rust",
      "c", "cpp",
      "markdown", "markdown_inline",
      "bash", "yaml", "toml", "regex", "diff",
    }
    require("nvim-treesitter").install(parsers)

    -- jsonc has no dedicated parser on the main branch; reuse the json one.
    vim.treesitter.language.register("json", "jsonc")

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user-treesitter-start", { clear = true }),
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then return end
        if pcall(vim.treesitter.start, buf, lang) then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
