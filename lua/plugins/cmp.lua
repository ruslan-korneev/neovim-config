return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
      opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    },
  },

  opts = function(_, opts)
    local cmp = require("cmp")

    local kind_icons = {
      Text = " ",
      Method = "󰆧",
      Function = "ƒ ",
      Constructor = " ",
      Field = "󰜢 ",
      Variable = " ",
      Constant = " ",
      Class = " ",
      Interface = "󰜰 ",
      Struct = " ",
      Enum = "了 ",
      EnumMember = " ",
      Module = "",
      Property = " ",
      Unit = " ",
      Value = "󰎠 ",
      Keyword = "󰌆 ",
      Snippet = " ",
      File = " ",
      Folder = " ",
      Color = " ",
    }

    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }

    opts.completion = {
      completeopt = "menu,menuone,noselect",
    }

    opts.sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    })

    opts.confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }

    opts.formatting = {
      format = function(entry, vim_item)
        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[NvimAPI]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
    }

    opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    })

    return opts
  end,
}
