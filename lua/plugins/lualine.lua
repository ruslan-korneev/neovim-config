local function getGitUserEmail()
  -- Function to execute a shell command and capture the output
  local function executeCommand(command)
    local file = io.popen(command)
    if file == nil then
      return nil
    end
    local output = file:read("*a")
    file:close()
    return output:match("^%s*(.-)%s*$") -- Trim whitespace
  end

  -- Try to get the email from the local repository config
  local localEmail = executeCommand("git config --local user.email 2>/dev/null")
  if localEmail and #localEmail > 0 then
    return localEmail
  end

  -- Fallback to the global config if no local email is found
  local globalEmail = executeCommand("git config --global user.email 2>/dev/null")
  if globalEmail and #globalEmail > 0 then
    return globalEmail
  end

  -- Return nil if no email is found
  return nil
end

-- Usage
-- local email = getGitUserEmail()
-- if email then
--     print("User email: " .. email)
-- else
--     print("No user email configured in local or global Git config.")
-- end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          local email = getGitUserEmail()
          if email then
            return "👤 " .. email
          else
            return ""
          end
        end,
      })
    end,
  },
}
