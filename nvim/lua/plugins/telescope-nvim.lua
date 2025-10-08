-- Fuzzy finder
return {
  -- https://github.com/nvim-telescope/telescope.nvim
  "nvim-telescope/telescope.nvim",
  lazy = true,
  branch = 'master',
  dependencies = {
    -- https://github.com/nvim-lua/plenary.nvim
    { "nvim-lua/plenary.nvim" },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
    {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" }
  },
  opts = function()
    return {
      defaults = {
        layout_config = {
          vertical = {
            width = 0.75
          }
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob", "!**/.git/*",
        }
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        buffers = {
          sort_mru = true,
        },
        -- help_tags = {
        --   theme = "ivy",
        -- },
        -- current_buffer_fuzz_find = {
        --   theme = "ivy",
        -- },
        -- lsp_document_symbols = {
        --   theme = "ivy",
        -- },
        -- jumplist = {
        --   theme = "ivy",
        -- },
        -- marks = {
        --   theme = "ivy",
        -- },
        -- tagstack = {
        --   theme = "ivy",
        -- },
        -- quickfix = {
        --   theme = "ivy",
        -- },
        -- oldfiles = {
        --   theme = "ivy",
        -- },
        -- lsp_references = {
        --   theme = "ivy",
        -- },
        -- current_buffer_fuzzy_find = {
        --   theme = "ivy",
        -- },
      }
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")

    opts.defaults.mappings = {
      n = {
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
        ["<M-q>"] = "smart_send_to_qflist",
        ["<M-a>"] = "smart_add_to_qflist",
        ["ii"] = actions.close,
      },
      i = {
        ["<esc>"] = actions.close,
        ["<C-space>"] = actions.to_fuzzy_refine,
      }
    }
    opts.extensions = {
      zoxide = {
        mappings = {
          default = {
            action = function(selection)
              vim.cmd.lcd(selection.path)
            end,
            after_action = function(selection)
              vim.notify("Directory changed to " .. selection.path)
            end,
          }
        }
      },
      live_grep_args = {
        debounce = 100,
        auto_quoting = false,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          }
        },
      },
      fzf = {}
    }

    telescope.setup(opts)

    telescope.load_extension("zoxide")
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end
}
