return {
  "AckslD/nvim-neoclip.lua",
  requires = {
    {'nvim-telescope/telescope.nvim'},
  },
  config = function()
    require('neoclip').setup({default_register = '+'})
  end,
}
