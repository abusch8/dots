vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 0
vim.opt.termguicolors = true
vim.g.netrw_liststyle = 1

vim.diagnostic.config({
    virtual_text = {
        enable = true,
        prefix = "●",
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
        },
    },
})
vim.cmd.colorscheme(_G.THEME)

