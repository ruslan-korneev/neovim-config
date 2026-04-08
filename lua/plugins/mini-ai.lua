-- mini.ai: extended text objects.
-- Custom `e` spec = "word with case" — lets `cie` / `2die` operate on a single
-- camelCase / snake_case segment of an identifier.
return {
  "echasnovski/mini.ai",
  event = "VeryLazy",
  opts = function()
    return {
      n_lines = 500,
      custom_textobjects = {
        e = {
          {
            "%u[%l%d]+%f[^%l%d]",
            "%f[%S][%l%d]+%f[^%l%d]",
            "%f[%P][%l%d]+%f[^%l%d]",
            "^[%l%d]+%f[^%l%d]",
          },
          "^().*()$",
        },
      },
    }
  end,
}
