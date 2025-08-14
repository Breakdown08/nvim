-- Вспомогательная функция для временного разрешения записи
local function with_modifiable(callback)
local modifiable = vim.api.nvim_buf_get_option(0, "modifiable")
if not modifiable then
    vim.api.nvim_buf_set_option(0, "modifiable", true)
    end

    callback()

    if not modifiable then
        vim.api.nvim_buf_set_option(0, "modifiable", false)
        end
        end

        -- 🔴 Добавить breakpoint
        vim.api.nvim_create_user_command("GodotBreakpoint", function()
        with_modifiable(function()
        vim.cmd("normal! obreakpoint")
        vim.cmd("write")
        end)
        end, {})
        vim.keymap.set("n", "<leader>b", ":GodotBreakpoint<CR>")

        -- ❌ Удалить все breakpoints в текущем файле
        vim.api.nvim_create_user_command("GodotDeleteBreakpoints", function()
        with_modifiable(function()
        vim.cmd("g/^[ \t]*breakpoint[ \t]*$/d")
        vim.cmd("write")
        end)
        end, {})
        vim.keymap.set("n", "<leader>BD", ":GodotDeleteBreakpoints<CR>")

        -- 🔍 Найти breakpoints во всём проекте
        vim.api.nvim_create_user_command("GodotFindBreakpoints", function()
        vim.cmd(":grep breakpoint | copen")
        end, {})
        vim.keymap.set("n", "<leader>BF", ":GodotFindBreakpoints<CR>")

        -- ✏️ Добавить комментарий для переводчиков
        vim.api.nvim_create_user_command("GodotTranslators", function()
        with_modifiable(function()
        vim.cmd('normal! A # TRANSLATORS: ')
        vim.cmd("write")
        end)
        end, {})
        vim.keymap.set("n", "<leader>tt", ":GodotTranslators<CR>")  -- добавил keymap, если забыл

        -- 📂 Перейти в корень проекта в NERDTree
        vim.api.nvim_create_user_command("GodotProjectRoot", function()
        if vim.fn.exists(":NERDTree") == 0 then
            vim.notify("NERDTree not available", vim.log.levels.WARN)
            return
            end

            if not _G.godot_project_path then
                vim.notify("Godot project path not set!", vim.log.levels.ERROR)
                return
                end

                vim.cmd("NERDTreeClose")
                vim.cmd("NERDTree " .. _G.godot_project_path)
                end, {})
        vim.keymap.set("n", "<leader>pr", ":GodotProjectRoot<CR>")

        -- 📜 Быстро закрыть/открыть окно поиска
        vim.keymap.set("n", "<leader>cq", ":cclose<CR>")
        vim.keymap.set("n", "<leader>co", ":copen<CR>")
