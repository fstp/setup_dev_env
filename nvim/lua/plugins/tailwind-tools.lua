-- tailwind-tools.lua
return {
  "fstp/tailwind-tools.nvim",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- optional
    "onsails/lspkind-nvim",
    "neovim/nvim-lspconfig",         -- optional
  },
  opts = {}                          -- your configuration
}
