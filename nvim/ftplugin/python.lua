local i = function(x)
  print(vim.inspect(x))
end

local function send_to_tmux(text, pane)
  local tmpname = os.tmpname()
  local f = io.open(tmpname, "w+")
  if f == nil then
    error("Could not open temporary file")
  end

  f:write(text .. "\n")
  f:close()

  local cmd = "tmux load-buffer " .. tmpname .. " && tmux paste-buffer -p -t " .. pane .. " && tmux send-keys -t " .. pane .. " enter"
  vim.fn.system(cmd)

  os.remove(tmpname)
end

local function send_line()
  local pane = 0
  local line = vim.api.nvim_get_current_line()
  local cmd = "tmux send-keys -t "..pane.." '"..line.."' Enter"
  vim.fn.system(cmd)
end

local function send_selection()
  local pane = 0
  local s = vim.fn.getpos("v")
  local e = vim.fn.getpos(".")
  local lines = vim.fn.getregion(s, e, {type = vim.fn.mode()})
  send_to_tmux(table.concat(lines, "\n"), pane)
end

local function send_buffer()
  local pane = 0
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  send_to_tmux(table.concat(lines, "\n"), pane)
end

vim.keymap.set("v", "<M-ö>", function() send_selection() end)
-- vim.keymap.set("n", "<M-l>", function() send_line() end)
vim.keymap.set("n", "<M-b>", function() send_buffer() end)

-- local function find_function_clause(node)
--   if node == nil then return nil
--   elseif node:type() == "module" then return nil
--   elseif node:type() == "function_definition" then return node
--   else return find_function_clause(node:parent()) end
-- end

-- vim.keymap.set("n", "<M-k>", function ()
--   local ts = require("vim.treesitter")
--   local ts_utils = require("nvim-treesitter.ts_utils")
--   local curr_node = ts_utils.get_node_at_cursor()
--   local function_node = find_function_clause(curr_node)

--   if function_node == nil then
--     print("No surrounding function")
--     return
--   end

--   local pane = 0
--   local text = ts.get_node_text(function_node, 0)
--   send_to_tmux(text, pane)
-- end)
