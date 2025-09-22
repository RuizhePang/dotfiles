local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
    augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim'
  use "rebelot/kanagawa.nvim"
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'nvim-tree/nvim-tree.lua'
  use 'christoomey/vim-tmux-navigator'
  use 'nvim-treesitter/nvim-treesitter'
  use 'p00f/nvim-ts-rainbow'
  use {
    "williamboman/mason.nvim",
    commit = "4da89f3"
  }
  use {
    "williamboman/mason-lspconfig.nvim",
    commit = "1a31f82"
  }
  use {
    'neovim/nvim-lspconfig',
    commit = "cf97d2485fc3f6d4df1b79a3ea183e24c272215e"
  }
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  use 'hrsh7th/cmp-path'

  use 'numToStr/Comment.nvim'
  use 'windwp/nvim-autopairs'

  use 'akinsho/bufferline.nvim'
  use 'lewis6991/gitsigns.nvim'

  use "ojroques/nvim-osc52"

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',  -- 文件检索
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {'lervag/vimtex'}

  use {"akinsho/toggleterm.nvim", tag = '*',}
  use {"github/copilot.vim"}

  if packer_bootstrap then
    require('packer').sync()
  end
end)
