local highlight_groups = { "@comment.warning" }

vim.b.hl_idx = 0
vim.api.nvim_set_hl(0, '@comment.warning', { fg = '#223249', bg = '#ff9e3b', bold = false })

local function find_function_clause(node)
  if node == nil then
    return nil
  elseif node:type() == "translation_unit" then
    return nil
  elseif node:type() == "function_definition" then
    return node
  else
    return find_function_clause(node:parent())
  end
end

vim.keymap.set("n", ",w", function()
  vim.b.hl_idx = (vim.b.hl_idx % #highlight_groups) + 1
  local hl_group = highlight_groups[vim.b.hl_idx]
  local q = require "vim.treesitter"
  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]
  local parser = vim.treesitter.get_parser(buf, 'c')
  local tree = parser:parse()[1]
  local curr_node = tree:root():named_descendant_for_range(row, col, row, col)
  local function_node = find_function_clause(curr_node)

  if function_node == nil then
    print("No surrounding function")
    return
  end

  if curr_node:type() ~= "identifier" then
    print("Not an identifier")
    return
  end

  local node_text = q.get_node_text(curr_node, buf)
  print("Highlighting \"" .. node_text .. "\"")

  local query = vim.treesitter.query.parse('c', '((identifier) @ident (#eq? @ident ' .. node_text .. '))')
  local ns = vim.api.nvim_create_namespace('namespace')
  for _, node in query:iter_captures(function_node, buf) do
    local sr, sc, er, ec = node:range()
    vim.api.nvim_buf_set_extmark(buf, ns, sr, sc, {
      end_row = er,
      end_col = ec,
      hl_group = hl_group,
    })
  end
  print(highlight_groups[vim.b.hl_idx])
end)

-- Clear all highlights in the buffer, hack for now but will be extended to only clear certain highlight groups later...
vim.keymap.set("n", ",c", "<cmd>lua vim.api.nvim_buf_clear_namespace(0, -1, 0, -1)<CR>")
