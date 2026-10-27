-- CodeCompanion + DeepSeek harness (dsh) over ACP
--
-- Agent side: `dsh --profile acp` (Agent Client Protocol over stdio).
-- Auth: dsh reads DEEPSEEK_API_KEY from ~/.dsh/.env, so no env is set here.
-- Keys: <leader>ac for chat, <leader>aC for actions.

if vim.fn.executable("dsh") ~= 1 then
  return {}
end

local function dsh_adapter()
  local helpers = require("codecompanion.adapters.acp.helpers")
  return {
    name = "dsh",
    formatted_name = "DeepSeek (dsh)",
    type = "acp",
    roles = {
      llm = "assistant",
      user = "user",
    },
    commands = {
      default = { "dsh", "--profile", "acp" },
    },
    defaults = {
      mcpServers = {},
      timeout = 120000, -- ms; edits + test runs can be slow
    },
    parameters = {
      protocolVersion = 1,
      clientCapabilities = {
        fs = { readTextFile = true, writeTextFile = true },
      },
      clientInfo = {
        name = "CodeCompanion.nvim",
        version = "1.0.0",
      },
    },
    handlers = {
      lifecycle = {
        setup = function()
          return true
        end,
        -- dsh advertises authMethods: [] — the key comes from ~/.dsh/.env
        auth = function()
          return true
        end,
      },
      request = {
        build_messages = helpers.build_messages,
      },
    },
  }
end

return {
  "olimorris/codecompanion.nvim",
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" },
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "dsh chat (ACP)", mode = { "n", "v" } },
    { "<leader>aC", "<cmd>CodeCompanionActions<cr>", desc = "dsh actions" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    adapters = {
      acp = {
        dsh = dsh_adapter,
      },
    },
    interactions = {
      chat = {
        adapter = "dsh",
      },
    },
  },
}
