return {
  {
    'zenbones-theme/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.set 'termguicolors'
      vim.cmd.set 'background=dark'
      vim.cmd.colorscheme 'zenwritten'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
