return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.2.0",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        config = function()
            require("telescope").setup {
                extensions = { fzf = {} }
            }
            local builtin = require("telescope.builtin")

            -- find file in working directory
            vim.keymap.set("n", "<leader>fd", builtin.find_files)
            -- grep in working directory
            vim.keymap.set("n", "<Leader>gd", require("telescope.builtin").live_grep, { noremap = true, silent = true })

            -- find file in neovim config
            vim.keymap.set(
                "n",
                "<leader>fn",
                function()
                    builtin.find_files {
                        cwd = vim.fn.stdpath("config")
                    }
                end
            )
            -- find file in neovim packages
            vim.keymap.set(
                "n",
                "<leader>fnp",
                function()
                    builtin.find_files {
                        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
                    }
                end
            )
            -- find file in quick access folder
            vim.keymap.set(
                "n",
                "<leader>fq",
                function()
                    builtin.find_files {
                        cwd = "C:\\Shortcuts",
--                        find_command = { "rg", "--files", "--sort", "path" },
                        previewer = false,
                        follow = true
                    }
                end
            )

            -- find help
            vim.keymap.set("n", "<leader>fh", builtin.help_tags)

        end
    }
}
