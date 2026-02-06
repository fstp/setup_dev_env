-- Code Tree Support / Syntax Highlighting
return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  dependencies = {
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  checkout = 'main',
  build = ':TSUpdate',
  opts = {
    highlight = {
      enable = true,
    },
    indent = { enable = true },
    auto_install = true, -- automatically install syntax support when entering new file type buffer
    ensure_installed = {
      'lua',
      'hcl',
      'terraform',
      'markdown',
      'markdown_inline',
      'luadoc',
      'c',
      'query',
      'html',
      'css',
      'tsx',
      'diff',
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['as'] = '@scope',
          ['ad'] = '@parameter.outer',
          ['id'] = '@parameter.inner',
        },
      },
    },
  },
  config = function(_, opts)
    --local configs = require("nvim-treesitter.configs")
    --configs.setup(opts)
  end
}
