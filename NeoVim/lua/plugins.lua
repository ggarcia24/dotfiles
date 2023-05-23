local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})
--- startup and add configure plugins
packer.startup(function(use)
  --

  use 'wbthomason/packer.nvim' -- Package manager
  use { "bluz71/vim-nightfly-colors", as = "nightfly" }
  use 'antonk52/bad-practices.nvim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'nvim-tree/nvim-web-devicons'
  use 'ggandor/leap.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'folke/which-key.nvim'
  -- use 'ntpeters/vim-better-whitespace'
  -- IDE Like features
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
  use 'windwp/nvim-autopairs'
  -- LSP / Languages
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'williamboman/mason.nvim' -- Easily install and manage LSP servers, DAP servers, linters, and formatters
  use 'williamboman/mason-lspconfig.nvim'
  -- FILE Navigation
  use 'nvim-tree/nvim-tree.lua'
  -- 
  use {
    'folke/todo-comments.nvim',
    requires = "nvim-lua/plenary.nvim",
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    ft = { 'python', 'css', 'php', 'typescript', 'javascript', 'lua', }
  }
  -- Dashboard
  use {
    'glepnir/dbsession.nvim',
    cmd = { 'SessionSave', 'SessionDelete', 'SessionLoad'},
    config = function()
      require('dbsession').setup({})
    end
  }
  use {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    requires = {'nvim-tree/nvim-web-devicons'}
  }
  -- Autocompletion
  use 'hrsh7th/nvim-cmp' 
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  -- use 'hrsh7th/cmp-vsnip'                             
  use 'hrsh7th/cmp-path'                              
  use 'hrsh7th/cmp-buffer'                            
  -- use 'hrsh7th/vim-vsnip'
  use 'mfussenegger/nvim-lint'
  use 'numToStr/Comment.nvim'
  use 'andymass/vim-matchup'
  use 'danymat/neogen'
  use {
    'ThePrimeagen/refactoring.nvim',
    requires = {
        {'nvim-lua/plenary.nvim'},
    }
  }
  use 'lewis6991/gitsigns.nvim'
  -- use 'ap/vim-css-color'
  -- use {
  --   'nvim-telescope/telescope.nvim',
  --   requires = 'nvim-lua/plenary.nvim'
  -- }
  -- PYTHON
  use { "jeetsukumaran/vim-pythonsense", ft = { "python" } }
  -- MARKDOWN
  use {
    'AckslD/nvim-FeMaco.lua',
    ft = 'markdown',
    config = 'require("femaco").setup()',
  }
  use {
    'dhruvasagar/vim-table-mode',
    ft = 'markdown'
  }
end)
