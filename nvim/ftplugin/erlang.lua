vim.b.hl_idx = 0

local highlight_groups = {"DiffAdd"}

local function find_function_clause(node)
  if node == nil then return nil
  elseif node:type() == "source_file" then return nil
  elseif node:type() == "function_clause" then return node
  else return find_function_clause(node:parent()) end
end

vim.keymap.set("n", ",w", function()
  vim.b.hl_idx = (vim.b.hl_idx % #highlight_groups) + 1
  local hl_group = highlight_groups[vim.b.hl_idx]
  local q = require"vim.treesitter"
  local ts_utils = require("nvim-treesitter.ts_utils")
  local curr_node = ts_utils.get_node_at_cursor()
  local function_node = find_function_clause(curr_node)

  if function_node == nil then
    print("No surrounding function")
    return
  end

  if (curr_node:type() ~= "var") then
    print("Not a variable")
    return
  end

  local node_text = q.get_node_text(curr_node, 0)
  print("Highlighting \""..node_text.."\"")

  local query = vim.treesitter.query.parse('erlang', '((var) @var (#eq? @var '..node_text..'))')
  local ns = vim.api.nvim_create_namespace('namespace')
  for _, node, metadata in query:iter_captures(function_node, 0) do
    ts_utils.highlight_node(node, 0, ns, hl_group)
  end
  print(highlight_groups[vim.b.hl_idx])
end)

-- Clear all highlights in the buffer, hack for now but will be extended to only clear certain highlight groups later...
vim.keymap.set("n", ",c", "<cmd>lua vim.api.nvim_buf_clear_namespace(0, -1, 0, -1)<CR>")

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
