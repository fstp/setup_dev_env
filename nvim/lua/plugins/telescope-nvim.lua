-- Fuzzy finder
return {
  -- https://github.com/nvim-telescope/telescope.nvim
  'nvim-telescope/telescope.nvim',
  lazy = true,
  branch = 'master',
  dependencies = {
    -- https://github.com/nvim-lua/plenary.nvim
    { 'nvim-lua/plenary.nvim' },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
    {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  opts = function()
    return {
      defaults = {
        layout_config = {
          vertical = {
            width = 0.75
          }
        },
      },
      pickers = {
        live_grep = {
          debounce = 100,
        }
      }
    }
  end,
  config = function (_, opts)
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    opts.defaults.mappings = {
      n = {
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
        ["<C-q>"] = "smart_send_to_qflist",
      },
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = "smart_send_to_qflist",
      }
    }
    opts.extensions = {
      -- Add extension configuration here
    }
    telescope.setup(opts)
  end
}
