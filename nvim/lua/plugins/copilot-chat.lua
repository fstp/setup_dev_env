return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    opts = {
      -- debug = true, -- Enable debugging
      debug = false, -- Enable debugging
      model = "claude-3.7-sonnet-thought",
      -- See Configuration section for rest
      mappings = {
        reset = {
          normal = "<C-r>",
        },
      },
    },
    config = function(_, opts)
      opts.window = {
        -- layout = 'float',
        -- width = 0.7,
        -- height = 0.7,
        border = 'rounded',
        title = '🤖 AI Assistant',
        zindex = 100,
      }
      opts.headers = {
        user = '👤 You: ',
        assistant = '🤖 Copilot: ',
        tool = '🔧 Tool: ',
      }
      require("CopilotChat").setup(opts)
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
