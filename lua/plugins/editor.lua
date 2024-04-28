return {
  "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-media-files.nvim",
  },
  keys = {
    {
      "<leader>f",
      function()
        local builtin = require("telescope.builtin")
        builtin.find_files({
          no_ignore = false,
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = true,
          initial_mode = "insert",
        })
      end,
    },
    {
      "<leader>r",
      function()
        local builtin = require("telescope.builtin")
        builtin.live_grep()
      end,
    },
    {
      "\\\\",
      function()
        local builtin = require("telescope.builtin")
        builtin.buffers()
      end,
    },
    {
      "<leader>t",
      function()
        local builtin = require("telescope.builtin")
        builtin.help_tags()
      end,
    },
    {
      "<leader>;",
      function()
        local builtin = require("telescope.builtin")
        builtin.resume()
      end,
    },
    {
      "<leader>e",
      function()
        local builtin = require("telescope.builtin")
        builtin.diagnostics()
      end,
    },
    {
      "<leader>s",
      function()
        local builtin = require("telescope.builtin")
        builtin.treesitter()
      end,
    },
    {
      "sf",
      function()
        local telescope = require("telescope")
        local function telescope_buffer_dir()
          return vim.fn.expand("%:p:h")
        end

        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 },
        })
      end,
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions

    opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
      wrap_results = true,
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      -- prompt_prefix = "  ",
      -- selection_caret = "  ",
      path_display = { "smart" },
      file_ignore_patterns = { ".git/", "node_modules" },
      color_devicons = true,
      winblend = 0,
      mappings = {
        n = {
          ["so"] = actions.select_tab,
          ["sv"] = actions.select_vertical,
          ["sh"] = actions.select_horizontal,
          ["q"] = actions.close,
          ["qq"] = actions.close,
        },
      },
    })
    opts.pickers = {
      diagnostics = {
        theme = "ivy",
        initial_mode = "normal",
        layout_config = { previewer_cutoff = 9999 },
      },
    }
    opts.extensions = {

      -- File Browser
      file_browser = {
        theme = "dropdown",
        -- disables newtr and use telescope file browser in its place
        hijack_newtr = true,
        mappings = {
          ["n"] = {
            ["n"] = fb_actions.create,
            -- command newdir not found
            -- ["D"] = fb_actions.newdir,
            ["h"] = fb_actions.goto_parent_dir,
            ["H"] = fb_actions.toggle_hidden,
            ["/"] = function()
              vim.cmd("startinsert")
            end,
            ["R"] = fb_actions.rename,
            ["d"] = fb_actions.remove,
            ["o"] = actions.select_tab,
          },
        },
      },
      media_files = {
        filetypes = { "png", "jpg", "jpeg", "pdf", "svg" },
        find_cmd = "rg",
      },
    }
    telescope.setup(opts)
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("media_files")
  end,
}
