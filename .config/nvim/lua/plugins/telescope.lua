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
            {
                "nvim-telescope/telescope-live-grep-args.nvim",
            },
        },
        config = function ()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            local lga_actions = require("telescope-live-grep-args.actions")
            local lga_shortcuts = require("telescope-live-grep-args.shortcuts")

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

            vim.keymap.set("n", "<C-p>", find_files)
            -- vim.keymap.set("n", "<leader>f*", function() vim.cmd("normal! *"); lga_shortcuts.grep_word_under_cursor() end)
            vim.keymap.set("n", "<leader>f*", lga_shortcuts.grep_word_under_cursor)
            vim.keymap.set("v", "<leader>f*", lga_shortcuts.grep_visual_selection)
            vim.keymap.set("n", "<leader>ff", builtin.find_files)
            vim.keymap.set("n", "<leader>fz", telescope.extensions.live_grep_args.live_grep_args)
            vim.keymap.set("n", "<leader>fb", function() builtin.buffers(previewless_opts) end)
            vim.keymap.set("n", "<leader>fr", builtin.resume)
            vim.keymap.set("n", "<leader>fh", builtin.history)

            local icon = icons.get("telescope")

            telescope.setup({
                defaults = {
                    prompt_prefix = icon == "" and " " or ("  " .. icon .. "  "),
                    selection_caret = " > ",
                    entry_prefix = "   ",
                },
                extensions = {
                    live_grep_args = {
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                                -- freeze the current list and start a fuzzy search in the frozen list
                                -- ["<C-z>"] = lga_actions.to_fuzzy_refine,
                            },
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
            })

            telescope.load_extension("live_grep_args")
        end
    },
}
