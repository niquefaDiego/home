return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "lua_ls",           -- lua-language-server
                "rust_analyzer",    -- rust-analyzer
--                "powershell_es",    -- powershell-editor-services
--                "csharp_ls",        -- csharp-language-server
--                "hls",              -- haskell-language-server
            }
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            {
                "neovim/nvim-lspconfig",
                config = function()
                end,
                dependencies = {
                    "folke/lazydev.nvim",
                    ft = "lua", -- only load on lua files
                    opts = {
                        library = {
                            -- See the configuration section for more details
                            -- Load luvit types when the `vim.uv` word is found
                            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                        },
                    },
                }
            }
        },
    }
}
