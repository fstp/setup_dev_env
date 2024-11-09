return {
  "ggandor/leap.nvim",
  lazy = false,
  config = function ()
    require('leap').create_default_mappings()
    require('leap').opts.safe_labels = {}
  end
}
