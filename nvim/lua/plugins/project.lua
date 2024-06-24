return {
  'ahmedkhalf/project.nvim',
  opts = {patterns = { ".project", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" }},
  config = function (_, opts)
    require("project_nvim").setup(opts)
  end
}
