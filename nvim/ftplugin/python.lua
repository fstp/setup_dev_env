local i = function(x)
  print(vim.inspect(x))
end

local function send_to_tmux(lines, pane)
  -- Create a temporary file to hold the lines
  local tmpname = os.tmpname()
  local f = io.open(tmpname, "w+")
  if f == nil then
    print("Could not open temporary file")
    return
  end

  for _, line in ipairs(lines) do
    f:write(line .. "\n")
  end

  f:close()

  -- Send the contents of the temporary file to the tmux pane
  local cmd = "tmux load-buffer " .. tmpname .. " && tmux paste-buffer -p -t " .. pane .. " && tmux send-keys -t " .. pane .. " Enter"
  vim.fn.system(cmd)

  -- Clean up the temporary file
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
  -- i(vim.fn.mode())
  local s = vim.fn.getpos("v")
  local e = vim.fn.getpos(".")
  local lines = vim.fn.getregion(s, e, {type = vim.fn.mode()})
  -- i(lines)
  send_to_tmux(lines, pane)
end

local function send_buffer()
  local pane = 0
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  -- i(lines)
  send_to_tmux(lines, pane)
end

vim.keymap.set("v", "<leader>j", function() send_selection() end)
vim.keymap.set("n", "<leader>l", function() send_line() end)
vim.keymap.set("n", "<leader>b", function() send_buffer() end)
