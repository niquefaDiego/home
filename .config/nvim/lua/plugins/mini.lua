return {
    {
        'nvim-mini/mini.nvim',
        version = '*',
        config = function()
            require('mini.icons').setup()
            require('mini.statusline').setup()
            require('mini.animate').setup({
                cursor = {
                    enable = false
                }
            })
            require('mini.surround').setup({
                n_lines = 200,
            })
            require('mini.tabline').setup({
                 format = function(buf_id, label)
                     if label == "mod.rs" then
                         local module_name = vim.fn.expand("%:h:t")
                         label = module_name .. "/" .. label
                     end
                     return MiniTabline.default_format(buf_id, label)
                 end
            })
            require('mini.files').setup()
            require('mini.cursorword').setup()
            require('mini.jump').setup({
                delay = {
                    highlight = 0, -- Delay between jump and highlighting all possible jumps
                    idle_stop = 10000000, -- Delay between jump and automatic stop if idle (no jump is done)
                }
            })
            require('mini.completion').setup()
            require('mini.sessions').setup()
            require('mini.visits').setup()
            require('mini.splitjoin').setup({
                mappings = {
                    toggle = 'ga',
                    split = '',
                    join = '',
                }
            })
            require('mini.comment').setup({
                mappings = {
                    comment = 'gc', -- Toggle comment in normal and visual mode
                    comment_line = 'gc', -- Toggle comment on current line
                    comment_visual = 'gc', -- Toggle comment on visual selection
                    textobject = 'gc', -- Define 'comment' textobject, so that 'dgc' works.
                },
            })
        end
    }
}
