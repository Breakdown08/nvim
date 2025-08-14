-- Загрузка lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
    end
    vim.opt.rtp:prepend(lazypath)

    -- Список плагинов
    return {
        -- 📂 NERDTree — файловый менеджер
        {
            "preservim/nerdtree",
            config = function()
            -- Клавиша для открытия/закрытия
            vim.keymap.set("n", "<F2>", ":NERDTreeToggle<CR>")

            -- Скрыть служебные файлы Godot
            if _G.is_godot_project then
                vim.cmd('let NERDTreeIgnore = ["\\.uid$", "server.pipe"]')
                end

                -- Показывать скрытые файлы
                vim.g.NERDTreeShowHidden = 1
                end,
        },

        -- 🐹 vim-go — плагин для разработки на Go
        {
            "fatih/vim-go",
            build = ":GoUpdateBinaries", -- установит goimports, gopls и т.д.
            ft = { "go" },
        },

        -- ⚙️ LSP Config — настройка LSP для Go
        {
            "neovim/nvim-lspconfig",
            config = function()
            local lspconfig = require("lspconfig")

            -- Настройка gopls
            lspconfig.gopls.setup({
                cmd = { "gopls" }, -- gopls должен быть в PATH
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    },
                },
            })

            -- Автоформатирование перед сохранением .go файлов
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                vim.lsp.buf.format()
                end,
            })
            end,
        },
    }
