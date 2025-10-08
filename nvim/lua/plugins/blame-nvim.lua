return {
  -- "FabijanZulj/blame.nvim",
  "fstp/blame.nvim",
  branch = "fix_commit_info_win",
  config = function()
    require("blame").setup()
  end
}
