-- Проверяет, является ли текущий каталог Go-проектом
local M = {}

function M.is_go_project()
-- Проверяем go.mod
if vim.fn.filereadable("go.mod") == 1 then
    return true
    end

    -- Или есть ли .go файлы в корне
    local go_files = vim.fn.glob("*.go", false, true)
    return #go_files > 0
    end

    return M
