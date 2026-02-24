return {
  "fstp/copilot-cmp",
  after = { "copilot.lua" },
  enabled = true,
  config = function ()
    require('copilot_cmp').setup()
  end
}
