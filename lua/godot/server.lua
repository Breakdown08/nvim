-- Определяем, является ли текущая директория проектом Godot

local paths_to_check = { "/", "/../" }
local cwd = vim.fn.getcwd()
local godot_project_path = ""
local is_godot_project = false

-- Ищем project.godot
for _, path in ipairs(paths_to_check) do
    if vim.uv.fs_stat(cwd .. path .. "project.godot") then
        is_godot_project = true
        godot_project_path = cwd .. path
        break
        end
        end

        -- Проверяем, запущен ли сервер
        if is_godot_project then
            local pipe_path = godot_project_path .. "/server.pipe"
            local is_server_running = vim.uv.fs_stat(pipe_path)

            if not is_server_running then
                vim.fn.serverstart(pipe_path)
                end
                end

                -- Экспортируем переменные для других модулей
                _G.godot_project_path = godot_project_path
                _G.is_godot_project = is_godot_project
