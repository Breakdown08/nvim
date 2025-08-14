-- lua/go/init.lua
-- Автоматическая настройка Go-проектов при открытии .go файла

local M = {}

-- При подключении регистрируем autocmd на FileType go
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function(args)
    local bufnr = args.buf

    -- Проверим, не в другом проекте ли мы (например, Python)
if _G.is_go_project then
    return
    end

    -- Переключаемся в буфер
    vim.api.nvim_win_set_buf(0, bufnr)

    -- Путь к setup.lua
    local ok, setup = pcall(require, "go.setup")
    if not ok then
        vim.notify("❌ go.setup: " .. setup, vim.log.levels.ERROR, { title = "nvim-go" })
        return
        end

        -- Выполняем настройку
        setup.setup()
        end,
        desc = "Auto-setup Go project",
        group = vim.api.nvim_create_augroup("nvim_go_autoload", { clear = true }),
})

-- Экспорт, если вдруг кто-то захочет вызвать вручную
function M.setup()
require("go.setup").setup()
end

return M
