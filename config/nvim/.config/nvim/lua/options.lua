-- Essential vim options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.swapfile = false
vim.opt.winborder = 'solid'

-- Clipboard sync
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time for better responsiveness
vim.opt.updatetime = 250

-- Configure split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show which line cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above/below cursor
vim.opt.scrolloff = 10

-- Don't show mode (already in status line)
vim.opt.showmode = false

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Preview substitutions live
vim.opt.inccommand = 'split'

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

