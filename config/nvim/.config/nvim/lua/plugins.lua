-- Plugin configuration using vim.pack

-- Theme
vim.pack.add({
  { src = "https://github.com/navarasu/onedark.nvim" },
})

local ok, onedark = pcall(require, 'onedark')
if ok then
  onedark.setup({
    style = 'warmer',
    transparent = true,
    code_style = {
      comments = 'italic',
      keywords = 'italic',
      functions = 'bold',
      strings = 'italic',
      variables = 'none',
    }
  })
  vim.cmd.colorscheme('onedark')
end

-- Treesitter
vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

local ok, configs = pcall(require, 'nvim-treesitter.configs')
if ok then
  configs.setup({
    ensure_installed = { 'astro', 'bash', 'c', 'cpp', 'css', 'diff', 'html', 'javascript', 'markdown', 'markdown_inline', 'typescript', 'lua' },
    highlight = { enable = true },
    indent = { enable = true },
    auto_install = true,
  })
end

-- Filetype and treesitter language registration
vim.filetype.add({
  extension = {
    mdx = 'mdx'
  }
})
vim.treesitter.language.register('markdown', 'mdx')

-- Telescope (fuzzy finder)
vim.pack.add({
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

-- Setup telescope and keymaps
local ok, telescope = pcall(require, 'telescope')
if ok then
  telescope.setup({})
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
end

-- LuaSnip (for snippets)
vim.pack.add({
  { src = 'https://github.com/L3MON4D3/LuaSnip' },
})

local ok, luasnip = pcall(require, 'luasnip')
if ok then
  luasnip.config.setup({})
end

-- nvim-cmp (autocompletion)
vim.pack.add({
  { src = 'https://github.com/hrsh7th/nvim-cmp' },
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
  { src = 'https://github.com/hrsh7th/cmp-path' },
  { src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
})

local ok, cmp = pcall(require, 'cmp')
if ok then
  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    completion = { completeopt = 'menu,menuone,noinsert' },
    mapping = cmp.mapping.preset.insert({
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.complete({}),
      ['<C-l>'] = cmp.mapping(function()
        if require('luasnip').expand_or_locally_jumpable() then
          require('luasnip').expand_or_jump()
        end
      end, { 'i', 's' }),
      ['<C-h>'] = cmp.mapping(function()
        if require('luasnip').locally_jumpable(-1) then
          require('luasnip').jump(-1)
        end
      end, { 'i', 's' }),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
    },
  })
end

-- LSP
vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
})

vim.lsp.enable({ "lua_ls", 'tinymist' })

-- Lua LSP config
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      completion = {
        callSnippet = 'Replace',
      },
    }
  }
})

-- LSP keymaps and autocommands
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local telescope_builtin = require('telescope.builtin')

    -- Jump to definition
    map('gd', telescope_builtin.lsp_definitions, '[G]oto [D]efinition')
    
    -- Find references
    map('gr', telescope_builtin.lsp_references, '[G]oto [R]eferences')
    
    -- Jump to implementation
    map('gI', telescope_builtin.lsp_implementations, '[G]oto [I]mplementation')
    
    -- Type definition
    map('<leader>D', telescope_builtin.lsp_type_definitions, 'Type [D]efinition')
    
    -- Document symbols
    map('<leader>ds', telescope_builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
    
    -- Workspace symbols
    map('<leader>ws', telescope_builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    
    -- Rename
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    
    -- Code action
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    
    -- Goto declaration
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    
    -- Format on save
    map('<leader>f', function()
      vim.lsp.buf.format({ async = false })
    end, '[F]ormat')
    
    -- Enable completion
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end,
})

-- Typst preview
vim.pack.add({
  { src = 'https://github.com/chomosuke/typst-preview.nvim' },
})

-- Neo-tree (file tree sidebar)
vim.pack.add({
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
})

local ok, neotree = pcall(require, 'neo-tree')
if ok then
  neotree.setup({
    filesystem = {
      window = {
        position = 'right',
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  })
  
  -- Keymap to toggle neo-tree
  vim.keymap.set('n', '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })
end

-- Statusline (lualine)
vim.pack.add({
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
})

local ok, lualine = pcall(require, 'lualine')
if ok then
  lualine.setup({
    options = {
      icons_enabled = true,
      theme = 'onedark',
      component_separators = { left = '│', right = '│' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  })
end

