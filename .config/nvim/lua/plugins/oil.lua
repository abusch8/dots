vim.api.nvim_create_user_command("Explore", "Oil", {})
vim.api.nvim_create_user_command("Ex", "Oil", {})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

return {
    {
        "stevearc/oil.nvim",
        opts = {
            columns = {
                "permissions",
                "size",
                "mtime",
            },
            keymaps = {
                ["<C-p>"] = false,
            },
            view_options = {
                show_hidden = true,
            },
            win_options = {
                signcolumn = "yes",
            },
        },
    },
    -- {
    --     "JezerM/oil-lsp-diagnostics.nvim",
    --     dependencies = { "stevearc/oil.nvim" },
    --     opts = {
    --         diagnostic_symbols = {
    --             error = "E",
    --             warn = "W",
    --             info = "I",
    --             hint = "H",
    --         },
    --     },
    -- },
}

