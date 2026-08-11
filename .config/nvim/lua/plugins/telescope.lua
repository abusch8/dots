return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function ()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local icons = require("icons")

            local previewless_opts = {
                previewer = false,
                layout_config = {
                    width = 0.5,
                    height = 0.5,
                },
            }

            local function find_files()
                builtin.find_files(vim.tbl_extend("force", previewless_opts, {
                    file_ignore_patterns = {
                        ".git",
                        ".npm",
                        ".venv",
                        "build",
                        "dist",
                        "node_modules",
                        "target",
                    },
                }))
            end

            local function live_grep()
                vim.cmd("normal! *")
                builtin.live_grep({
                    default_text = vim.fn.expand("<cword>")
                })
            end

            vim.keymap.set("n", "<C-p>", find_files)
            vim.keymap.set("n", "<leader>f*", live_grep)

            vim.keymap.set("n", "<leader>ff", builtin.find_files)
            vim.keymap.set("n", "<leader>fz", builtin.live_grep)
            vim.keymap.set("n", "<leader>fb", function() builtin.buffers(previewless_opts) end)
            vim.keymap.set("n", "<leader>fh", builtin.help_tags)

            local icon = icons.get("telescope")

            telescope.setup({
                defaults = {
                    prompt_prefix = icon == "" and " " or ("  " .. icon .. "  "),
                    selection_caret = " > ",
                    entry_prefix = "   ",
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
            })
        end
    },
}
