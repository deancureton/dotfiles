-- Essential keymaps

-- Clear highlights on search when pressing <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Window navigation with Ctrl+hjkl
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Exit terminal mode easier
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Custom keymaps
vim.keymap.set('n', '<leader>w', function()
  vim.lsp.buf.format({ async = false })
  vim.cmd('write')
end, { desc = 'Format and write' })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>p', ':TypstPreview<CR>', { desc = 'Typst Preview' })

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

