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
  use({
    'wbthomason/packer.nvim'
  })
  use({
    "RuizhePang/naudio.nvim",
    after = "image.nvim",
  })
  use({
    "3rd/image.nvim",
  })
  use {
      'folke/tokyonight.nvim',
      commit = "38d01f75d64c2862216cd4271aa7576b9dd20da8"
  }
  use({'kyazdani42/nvim-web-devicons'})
  use({
    "rebelot/kanagawa.nvim",
    commit = "19d9f23556d264b5721e04035709acdb20599904"
  })
  use({
    'nvim-lualine/lualine.nvim',
    commit = "02d61f515e7d88e1b02366ca972aecf2768d53df",
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  })
  use({ 
    'nvim-tree/nvim-tree.lua',
    commit = "ae595611fb2225f2041996c042aa4e4b8663b41e"
  })
  use 'christoomey/vim-tmux-navigator'
  use({
    'nvim-treesitter/nvim-treesitter',
    branch = "master",
    run = ":TSUpdate",
  })
  use({
    "HiPhish/rainbow-delimiters.nvim"
  })
  use {
    "williamboman/mason.nvim",
  }
  use {
    "williamboman/mason-lspconfig.nvim",
    commit = "1a31f82"
  }
  use {
    'neovim/nvim-lspconfig',
    commit = "562487bc108bf73c2493f9e701b9334b48163216"
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
  use {
    'lewis6991/gitsigns.nvim',
    commit="751bfae26a3561394afcafdf92b0dc52988ce436"
  }

  use "ojroques/nvim-osc52"

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',  -- 文件检索
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {"akinsho/toggleterm.nvim", tag = '*',}
  use {"github/copilot.vim"}

  if packer_bootstrap then
    require('packer').sync()
  end
end)
