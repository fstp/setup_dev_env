return {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua" },
  enabled = false,
  config = function ()
    require('copilot_cmp').setup()
  end
}
