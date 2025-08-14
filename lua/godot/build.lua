-- Запустить проект в режиме отладки
vim.api.nvim_create_user_command("GodotRun", function()
local project_path = _G.godot_project_path:gsub("/$", "")
vim.cmd('!godot --path "' .. project_path .. '" --debug')
end, {})

-- Собрать проект (экспорт)
vim.api.nvim_create_user_command("GodotBuild", function()
local project_path = _G.godot_project_path:gsub("/$", "")
-- Замени "Linux/X11" на свой экспортный пресет
vim.cmd('!godot --path "' .. project_path .. '" --export-debug "Linux/X11" ./build/game.x86_64')
end, {})

-- Горячие клавиши
vim.keymap.set("n", "<leader>gr", ":GodotRun<CR>")
vim.keymap.set("n", "<leader>gb", ":GodotBuild<CR>")
