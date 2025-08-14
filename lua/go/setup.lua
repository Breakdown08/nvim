local utils = require("go.utils")

local M = {}

function M.setup()
-- Уже инициализирован? Пропускаем
if _G.is_go_project then
    return
    end

    -- Проверяем, Go-ли это проект
    if not utils.is_go_project() then
        return
        end

        _G.is_go_project = true
        local bufnr = vim.api.nvim_get_current_buf()

        -- 🔧 Keymaps
        local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "<leader>rt", ":GoTestFunc<CR>", ".UnitTesting: Run test (func)")
        map("n", "<leader>RT", ":GoTest<CR>", ".UnitTesting: Run test (package)")
        map("n", "<leader>gb", ":GoBuild<CR>", "Build: Run go build")
        map("n", "<leader>gr", ":GoRun<CR>", "Run: Execute main package")
        map("n", "<leader>gi", ":GoImport<CR>", "Import: Add missing import")
        map("n", "<leader>gf", ":%GoImport<CR>", "Import: Add all missing imports")
        map("n", "<leader>gd", ":GoDoc<CR>", "Docs: Show documentation")
        map("n", "<leader>gc", ":GoCoverageToggle<CR>", "Coverage: Toggle coverage")
        -- 📂 Перейти в корень проекта в NERDTree
        vim.api.nvim_create_user_command("GoProjectRoot", function()
        if vim.fn.exists(":NERDTree") == 0 then
            vim.notify("NERDTree not available", vim.log.levels.WARN)
            return
            end

            if not _G.go_project_path then
                vim.notify("Godot project path not set!", vim.log.levels.ERROR)
                return
                end

                vim.cmd("NERDTreeClose")
                vim.cmd("NERDTree " .. _G.go_project_path)
                end, {})
        vim.keymap.set("n", "<leader>pr", ":GoProjectRoot<CR>")

        -- 📝 Buffer-local options
        vim.api.nvim_buf_set_option(bufnr, "expandtab", true)
        vim.api.nvim_buf_set_option(bufnr, "shiftwidth", 4)
        vim.api.nvim_buf_set_option(bufnr, "tabstop", 4)
        vim.api.nvim_buf_set_option(bufnr, "softtabstop", 4)

        -- ✅ Уведомление
        vim.notify("Go project loaded 🚀", vim.log.levels.INFO, {
            title = "nvim-go",
            timeout = 3000,
        })

        -- 🛠 Пользовательские команды
        vim.api.nvim_create_user_command("GoRunProject", function()
        vim.cmd("GoRun")
        end, { desc = "Run current Go project", nargs = "?" })

        vim.api.nvim_create_user_command("GoTestAll", function()
        vim.cmd("GoTest -v ./...")
        end, { desc = "Run all tests recursively" })

        vim.api.nvim_create_user_command("GoFindUsages", function()
        local word = vim.fn.expand("<cword>")
        vim.cmd(string.format(":grep -r '%s' . | copen", word))
        end, { desc = "Find usages of current word" })
        end

        return M
