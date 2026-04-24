-- Code Tree Support / Syntax Highlighting
return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  dependencies = {
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  branch = 'main',
  build = ':TSUpdate',
  opts = {
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
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
    local ensureInstalled = {
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
      'erlang',
      'yaml',
    }
    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim.iter(ensureInstalled)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
    require('nvim-treesitter').install(parsersToInstall)
  end,
  config = function(_, opts)
    --local configs = require("nvim-treesitter.configs")
    --configs.setup(opts)
  end
}
