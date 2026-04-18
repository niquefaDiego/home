return { {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        style = "night", -- your preferred style: "night", "storm", "moon", or "day"
        -- other options go here, e.g. transparent = true,
    },
    init = function()
        -- Set the colorscheme
        vim.cmd.colorscheme("tokyonight")
    end
}}
