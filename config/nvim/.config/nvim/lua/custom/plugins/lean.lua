return {
  {
    'Julian/lean.nvim',
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
    },
    ---@type lean.Config
    opts = {
      lsp = {},
      mappings = true,
    },
  },
}
