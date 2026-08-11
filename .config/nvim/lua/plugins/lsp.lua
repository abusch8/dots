return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "bashls",
                "clangd",
                "lua_ls",
                "pyright",
                "lemminx",
            },
        },
        lazy = false,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local configs = {
                bashls = {
                    cmd = { "bash-language-server", "start" },
                    filetypes = { "bash", "sh" },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
            }
            for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
                vim.lsp.config(server, configs[server] or {})
            end
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        },
        build = ":TSUpdate",
    },
}
