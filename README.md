# NeoVim Configuration

## Using

- [NeoVim](https://neovim.io/)
- [LazyVim](https://lazyvim.github.io/installation)
- [wakatime](https://wakatime.com/neovim)
- [codeium](https://codeium.com/vim_tutorial?extensionName=neovim)
- [lsp-saga](https://github.com/nvimdev/lspsaga.nvim)
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
- [autopairs](https://github.com/windwp/nvim-autopairs)

## DAP Notes

For FastAPI or any other configuration you might need to create a folder `.vscode`, where you store your debugger config inside `luanch.json`:
Example for python FastAPI:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Python Debugger: FastAPI",
      "type": "debugpy",
      "request": "launch",
      "module": "uvicorn",
      "args": ["main:app", "--port", "8000"],
      "jinja": true
    }
  ]
}
```
