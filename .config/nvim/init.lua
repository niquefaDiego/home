----- VIM settings -----

-- set <space> as the leader key (See `:help mapleader`)
vim.g.mapleader = ' '
vim.g.maplocalleader = '//'

-- show line number
vim.o.number = true

-- show tab ('\t') as 4 spaces
vim.o.tabstop = 4

-- insert/remove 4 spaces when using the shift operations (>> or <<)
vim.o.shiftwidth = 4

-- replace tab with spaces
vim.o.expandtab = true

-- highlight the cursor's line
vim.o.cursorline = true

-- do not show mode ("-- INSERT --" at the bottom)
vim.o.showmode = false

-- keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- share clipboard with OS
-- Not using it because it might break Ctrl-v (block mode for multi-line edits)
-- vim.o.clipboard = "unnamedplus"

-- idle ms for saving file to disk for crash-recovery, default is 4000
vim.o.updatetime = 888

-- mapped sequence wait time in ms (default is 1000)
vim.o.timeoutlen = 300

-- vertical line at 100 characters
vim.opt.colorcolumn = "100"

vim.o.list = true
vim.opt.listchars = {tab = '» ', trail = '·', nbsp = '␣'}

-- minimum number of lines to keep below or above the cursor
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- see `:help 'confirm'`
vim.o.confirm = true

-- vertical split to the right by default
vim.o.splitright = true

-- clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = {
        source = 'if_many',
        spacing = 2,
    },
}

----- Quickfix -----
local function toggle_quickfix()
  -- Check if a quickfix window exists and is open
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  -- If not open, check if the list has entries and open it
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd.copen()
  end
end
vim.keymap.set('n', '<Leader>c', toggle_quickfix, { desc = "Toggle Quickfix Window" })
vim.keymap.set("n", "<leader>]", ":cnext<CR>" , { desc = "Go to next quicklist item" })
vim.keymap.set("n", "<leader>[", ":cprevious<CR>" , { desc = "Go to previous quicklist item" })

vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float(0, { scope = "line" })
end, { desc = "Open full diagnostic message" })

require("config.lazy")

vim.cmd[[colorscheme tokyonight]]

-- lsp mappings
 local lsp_attach_group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true })
-- Define the autocommand for the LspAttach event
vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_attach_group,
  callback = function(event)
    -- event.buf contains the buffer number
    local bufnr = event.buf

    -- Set buffer-local options (optional)
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Set up buffer-specific keymaps
    local function map(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end

    -- Keymaps for common LSP functions
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
    map('<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, 'Format Buffer')
  end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LspFormatting", {}),
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- open working directory with mini.files
vim.keymap.set("n", "<leader>od", function()
    vim.cmd[[lua MiniFiles.open()]]
end, { silent = true })

-- exit buffer
vim.keymap.set("n", "<leader>q", function()
    vim.cmd[[bd]]
end, { silent = true })

vim.keymap.set("n", "<leader>m", ":messages<CR>", { desc = "Display neovim messages" })

-- Copy relative path
vim.keymap.set('n', '<leader>yp', function()
  vim.fn.setreg('+', vim.fn.expand('%'))
  print("Copied relative path: " .. vim.fn.expand('%'))
end, { desc = 'Copy relative file path' })

-- Close mini.files when opening telescope
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopeFindPre",
  callback = function() if _G.MiniFiles then _G.MiniFiles.close() end end
})

require('shortcuts')
require('scroll')
