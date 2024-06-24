-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- General keymaps
keymap.set("i", "jk", "<ESC>") -- exit insert mode with jk 
keymap.set("i", "ii", "<ESC>") -- exit insert mode with ii
keymap.set("v", "ii", "<ESC>") -- exit visual mode with ii
keymap.set("n", "gx", ":!open <c-r><c-a><CR>") -- open URL under cursor

-- Window movement
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open a new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close a tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- previous tab

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>") -- put diff from current to other during diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- get diff from left (local) during merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- get diff from right (remote) during merge
keymap.set("n", "<leader>cn", "]c") -- next diff hunk
keymap.set("n", "<leader>cp", "[c") -- previous diff hunk

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>") -- open quickfix list
keymap.set("n", "<leader>qf", ":cfirst<CR>") -- jump to first quickfix list item
keymap.set("n", "<leader>qn", ":cnext<CR>") -- jump to next quickfix list item
keymap.set("n", "<leader>qp", ":cprev<CR>") -- jump to prev quickfix list item
keymap.set("n", "<leader>ql", ":clast<CR>") -- jump to last quickfix list item
keymap.set("n", "<leader>qc", ":cclose<CR>") -- close quickfix list

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle maximize tab

-- Nvim-tree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>") -- toggle file explorer
keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>") -- toggle focus to file explorer
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>") -- find file in file explorer

-- Telescope
keymap.set('n', '<leader>fp', ":Telescope projects<CR>")
keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
keymap.set('n', '<leader>fl', require('telescope.builtin').oldfiles, {})

--keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
keymap.set('n', '<leader>fg', require('telescope').extensions.live_grep_args.live_grep_args, {})

keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})
keymap.set('n', '<leader>fs', require('telescope.builtin').current_buffer_fuzzy_find, {})
keymap.set('n', '<leader>fo', require('telescope.builtin').lsp_document_symbols, {})
keymap.set('n', '<leader>fi', require('telescope.builtin').lsp_incoming_calls, {})
--keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({default_text=":method:"}) end)
-- keymap.set('n', '<leader>fm', require('telescope.builtin').treesitter, {})
keymap.set('n', '<leader>fm', require('telescope.builtin').marks, {})
keymap.set('n', '<leader>fj', require('telescope.builtin').jumplist, {})
--keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, {})
keymap.set('n', '<leader>fw', function() require('telescope.builtin').current_buffer_fuzzy_find{default_text = vim.fn.expand("<cword>")} end)
keymap.set('n', '<leader>fr', require('telescope.builtin').resume, {})
keymap.set('n', '<leader>fn', require('telescope').extensions.neoclip.default, {})

local floating_win = -1
local floating_height = 40
local floating_width = 100

local close_floating = function(_)
  if vim.api.nvim_win_is_valid(floating_win) then
    vim.api.nvim_win_close(floating_win, false)
    floating_win = -1
  end
end

local focus_floating = function(_)
  if vim.api.nvim_win_is_valid(floating_win) then
    vim.api.nvim_set_current_win(floating_win)
  end
end

local open_floating = function()
  -- close_floating({})
  -- floating_win = vim.api.nvim_open_win(0, true,
  --   {relative="cursor", row=10, col=80, width=floating_width, height=floating_height, border="rounded", anchor="SW"})
  close_floating({})
  floating_win = vim.api.nvim_open_win(0, true,
    {relative="win", row=50, col=100, width=floating_width, height=floating_height, border="rounded", anchor="SW"})
end

local change_width_floating = function(delta)
  if (floating_width <= 10) then
    return
  end
  local width = floating_width + delta
  if vim.api.nvim_win_is_valid(floating_win) then
    vim.api.nvim_win_set_width(floating_win, width)
    floating_width = width
  end
end

local current_buffer = function(_)
  vim.print(vim.fn.expand("%:p"))
end

local wrapper_floating = function(opts)
  open_floating()
  return require('telescope.builtin').lsp_definitions(opts)
end

local wrapper = function(opts)
  local lookup = {
    ["t"] = "tabnew",
    ["s"] = "below",
    ["v"] = "right",
  }
  local user_input = vim.fn.input("[tab, split, vsplit]: ")
  vim.print(user_input)
  if opts == nil then
    opts = {reuse_win = true}
  end
  if user_input ~= "" then
    local split = lookup[user_input]
    if split == "tabnew" then
      vim.cmd("tab split")
    elseif split ~= nil then
      vim.api.nvim_open_win(0, true, {split = split})
    else
      vim.print("Invalid split type: " .. user_input)
      return
    end
  end
  return require('telescope.builtin').lsp_definitions(opts)
end

-- Floating window management
keymap.set('n', '<leader>wc', close_floating, {})
keymap.set('n', '<leader>wf', focus_floating, {})
keymap.set('n', '<leader>wo', wrapper_floating, {})
keymap.set('n', '<leader>wp', current_buffer, {})
keymap.set('n', '<leader>wj', function() change_width_floating(-10) end, {})

-- Remote management
keymap.set('n', '<leader>rp', '<cmd>silent !~/script/rsync_push<CR>')

local accept_word = function()
  require("copilot.suggestion").accept_word({})
  require("copilot.suggestion").next({})
end

local accept_line = function()
  require("copilot.suggestion").accept_line({})
  require("copilot.suggestion").next({})
end

local clear_suggestion = function()
  require("copilot.suggestion").dismiss({})
end

-- Copilot
keymap.set('i', '<C-right>', accept_word, {})
keymap.set('i', '<C-up>', accept_line, {})
keymap.set('i', '<C-down>', clear_suggestion, {})

-- LSP
keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>')
keymap.set('n', '<leader>gd', wrapper, {})
--keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references, {})
keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>')
keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
keymap.set('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>')

-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
keymap.set("n", '<leader>go', function()
  if vim.bo.filetype == 'python' then
    vim.api.nvim_command('PyrightOrganizeImports')
  end
end)

keymap.set("n", '<leader>tc', function()
  if vim.bo.filetype == 'python' then
    require('dap-python').test_class();
  end
end)

keymap.set("n", '<leader>tm', function()
  if vim.bo.filetype == 'python' then
    require('dap-python').test_method();
  end
end)

-- Debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>')
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end)
keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end)
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)
keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end)

