return {
    -- 📂 NERDTree — файловый менеджер
    {
        "preservim/nerdtree",
        config = function()
        vim.keymap.set("n", "<F2>", ":NERDTreeToggle<CR>")

        -- Скрыть служебные файлы Godot
        if _G.is_godot_project then
            vim.cmd('let NERDTreeIgnore = ["\\.uid$", "server.pipe"]')
            end

            vim.g.NERDTreeShowHidden = 1
            end,
    },

    -- 🐹 vim-go — плагин для разработки на Go
    {
        "fatih/vim-go",
        build = ":GoUpdateBinaries",
        ft = "go",
        -- Добавим lazy-load на ft
        cmd = { "GoBuild", "GoTest", "GoImport" },
    },

    -- ⚙ LSP Config — настройка LSP для Go
    {
        "neovim/nvim-lspconfig",
        config = function()
        local lspconfig = require("lspconfig")
        lspconfig.gopls.setup({
            cmd = { "gopls" },
            settings = {
                gopls = {
                    analyses = { unusedparams = true },
                    staticcheck = true,
                },
            },
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
            vim.lsp.buf.format()
            end,
        })
        end,
    },
}
