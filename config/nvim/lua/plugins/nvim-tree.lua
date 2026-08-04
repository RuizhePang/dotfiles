-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
    git_ignored = false,
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    api.config.mappings.default_on_attach(bufnr)          -- keep defaults
    require("nvim.sfx_player").nvimtree_attach(bufnr)      -- add audio handling
  end,
})
