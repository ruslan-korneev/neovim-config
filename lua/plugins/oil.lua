return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Oil",
  keys = {
    {
      "<leader>fe",
      function()
        _G._oil_git_filter = nil
        require("oil").open_float()
      end,
      desc = "Oil: float explorer",
    },
    {
      "<leader>ge",
      function()
        -- Collect changed + staged files relative to git root, open oil
        -- float at the root, and hide everything that isn't part of the set.
        local root = vim.fs.root(0, ".git")
        if not root then
          vim.notify("Not inside a git repository", vim.log.levels.WARN)
          return
        end

        local out = vim.fn.systemlist({
          "git", "-C", root, "status", "--porcelain=v1", "--untracked-files=all",
        })
        if vim.v.shell_error ~= 0 then
          vim.notify("git status failed", vim.log.levels.ERROR)
          return
        end

        local allowed = {}
        local function add(path)
          local abs = root .. "/" .. path
          -- Strip trailing slash git appends for directories.
          abs = abs:gsub("/$", "")
          allowed[abs] = true
          local parent = vim.fs.dirname(abs)
          while parent and parent ~= root and parent ~= "/" and parent ~= "" do
            allowed[parent] = true
            parent = vim.fs.dirname(parent)
          end
          allowed[root] = true
        end

        for _, line in ipairs(out) do
          if #line > 3 then
            local path = line:sub(4)
            local _, _, new = path:find("%-> (.+)$")
            path = new or path
            path = path:gsub('^"(.*)"$', "%1")
            add(path)
          end
        end

        if next(allowed) == nil then
          vim.notify("No changed or staged files", vim.log.levels.INFO)
          return
        end

        _G._oil_git_filter = allowed
        require("oil").open_float(root)
      end,
      desc = "Oil: git changed/staged files",
    },
  },
  opts = {
    default_file_explorer = false,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, _)
        if _G._oil_git_filter then
          return false
        end
        return vim.startswith(name, ".")
      end,
      is_always_hidden = function(name, bufnr)
        local filter = _G._oil_git_filter
        if not filter then
          return false
        end
        local dir = require("oil").get_current_dir(bufnr)
        if not dir then
          return false
        end
        local full = (dir:gsub("/$", "")) .. "/" .. name
        return not filter[full]
      end,
    },
    float = {
      padding = 4,
      max_width = 0.8,
      max_height = 0.8,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
      ["<Esc>"] = { "actions.close", mode = "n" },
    },
  },
}
