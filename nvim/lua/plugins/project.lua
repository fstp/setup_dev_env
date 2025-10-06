return {
  'ahmedkhalf/project.nvim',
  opts = {
    patterns = { ".project", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    show_hidden = true,
    manual_mode = true,
    silent_chdir = false,
    scope_chdir = "win"
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
  end
}
