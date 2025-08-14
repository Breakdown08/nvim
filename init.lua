-- Путь к core/plugins.lua
local core_plugins = vim.fn.stdpath("config") .. "/lua/core/plugins.lua"

-- Проверка, что файл с плагинами существует
if vim.fn.filereadable(core_plugins) == 0 then
  vim.api.nvim_err_writeln("Не найден файл core/plugins.lua")
  return
  end

require("core.settings")
require("core.keymaps")
require("lazy").setup(require("core.plugins"))
pcall(require, "godot.init")
pcall(require, "go.init")
