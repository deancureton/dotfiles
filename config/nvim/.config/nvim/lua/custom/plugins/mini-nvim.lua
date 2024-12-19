return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      -- require('mini.icons').setup()
      require('mini.sessions').setup()
      require('mini.tabline').setup()
    end,
  },
}
