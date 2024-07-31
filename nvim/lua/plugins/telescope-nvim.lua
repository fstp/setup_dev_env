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
    local lga_actions = require("telescope-live-grep-args.actions")

    opts.defaults.mappings = {
      n = {
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
        ["<M-q>"] = "smart_send_to_qflist",
        ["<M-a>"] = "smart_add_to_qflist",
      },
      i = {
        ["<esc>"] = actions.close,
        ["<C-space>"] = actions.to_fuzzy_refine,
      }
    }
    opts.extensions = {
      live_grep_args = {
        auto_quoting = false,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          }
        }
      }
    }
    telescope.setup(opts)
  end
}
