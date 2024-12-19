return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('harpoon'):setup()
    end,
    keys = {
      {
        '<leader>hx',
        function()
          require('harpoon'):list():add()
        end,
      },
      {
        '<leader>hn',
        function()
          require('harpoon'):list():next()
        end,
      },
      {
        '<leader>hp',
        function()
          require('harpoon'):list():prev()
        end,
      },
      { '<leader>hm', '<cmd>Telescope harpoon marks<cr>' },
    },
  },
}
