return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'main',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').install {
                'c',
                'c_sharp',
                'cpp',
                'css',
                'haskell',
                'html',
                'javascript',
                'powershell',
                'python',
                'rust',
                'typescript',
            }
        end,
    }
}
