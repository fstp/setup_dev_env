-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- Load current project file
keymap.set("n", "<leader>ll", function()
  local basename = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
  vim.opt.rtp:append(vim.fn.getcwd())
  require(basename)
end, { desc = "Load current project lua file" })

-- General keymaps
keymap.set("i", "jk", "<ESC>")                 -- exit insert mode with jk
keymap.set("i", "ii", "<ESC>")                 -- exit insert mode with ii
keymap.set("v", "ii", "<ESC>")                 -- exit visual mode with ii
keymap.set("n", "gx", ":!open <c-r><c-a><CR>") -- open URL under cursor

-- Window movement
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")

-- Tab management
keymap.set("n", "<leader>to", ":tab split<CR>") -- open a new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>")  -- close a tab
keymap.set("n", "<leader>tn", ":tabn<CR>")      -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>")      -- previous tab
keymap.set('n', '<leader>tf', require('telescope-tabs').list_tabs, { desc = "List and search tabs" })

-- Overlook popup bindings
keymap.set("n", "<leader>pd", require("overlook.api").peek_definition, { desc = "Peek definition" })
keymap.set("n", "<leader>pp", require("overlook.api").peek_cursor, { desc = "Peek cursor" })
keymap.set("n", "<leader>pu", require("overlook.api").restore_popup, { desc = "Restore last popup" })
keymap.set("n", "<leader>pU", require("overlook.api").restore_all_popups, { desc = "Restore all popups" })
keymap.set("n", "<leader>pc", require("overlook.api").close_all, { desc = "Close all popups" })
keymap.set("n", "<leader>ps", require("overlook.api").open_in_split, { desc = "Open popup in split" })
keymap.set("n", "<leader>pv", require("overlook.api").open_in_vsplit, { desc = "Open popup in vsplit" })
keymap.set("n", "<leader>pt", require("overlook.api").open_in_tab, { desc = "Open popup in tab" })
keymap.set("n", "<leader>po", require("overlook.api").open_in_original_window, { desc = "Open popup in current window" })
keymap.set("n", "<leader>pf", require("overlook.api").switch_focus, { desc = "Switch focus between popup/main window" })

-- MiniHarp
keymap.set('n', '<leader>mm', require('miniharp').toggle_file, { desc = 'miniharp: toggle file mark' })
keymap.set('n', '<leader>mc', require('miniharp').clear, { desc = 'miniharp: clear marks' })
keymap.set('n', '<leader>ml', require('miniharp').show_list, { desc = 'miniharp: list marks' })
keymap.set('n', '<leader>ms', require('miniharp').save, { desc = 'miniharp: save marks' })
keymap.set('n', '<M-n>', require('miniharp').next, { desc = 'miniharp: next file mark' })
keymap.set('n', '<M-p>', require('miniharp').prev, { desc = 'miniharp: prev file mark' })

-- Diff keymaps
-- keymap.set("n", "<leader>cc", ":diffput<CR>") -- put diff from current to other during diff
-- keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- get diff from left (local) during merge
-- keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- get diff from right (remote) during merge
-- keymap.set("n", "<leader>cn", "]c") -- next diff hunk
-- keymap.set("n", "<leader>cp", "[c") -- previous diff hunk

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>")  -- open quickfix list
keymap.set("n", "<leader>qf", ":cfirst<CR>") -- jump to first quickfix list item
-- keymap.set("n", "<leader>qn", ":cnext<CR>") -- jump to next quickfix list item
-- keymap.set("n", "<leader>qp", ":cprev<CR>") -- jump to prev quickfix list item
keymap.set("n", "<leader>ql", ":clast<CR>")  -- jump to last quickfix list item
keymap.set("n", "<leader>qc", ":cclose<CR>") -- close quickfix list

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle maximize tab

-- Nvim-tree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>")   -- toggle file explorer
keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>")    -- toggle focus to file explorer
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>") -- find file in file explorer

-- Telescope
keymap.set('n', '<leader>fp', ":Telescope projects<CR>", { desc = "Find projects" })
keymap.set('n', '<leader>fz', ":Telescope zoxide list<CR>", { desc = "Zoxide: Find folders" })
keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Find files" })
keymap.set('n', '<leader>fl', require('telescope.builtin').oldfiles, { desc = "Find recently opened files" })

-- keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
keymap.set('n', '<leader>fgg', require('telescope').extensions.live_grep_args.live_grep_args,
  { desc = "Grep entire project" })

keymap.set('n', '<leader>fgb', function()
  require('telescope.builtin').live_grep({ grep_open_files = true })
end, { desc = "Grep open buffers" })

keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Find buffers" })
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "Search help" })
keymap.set('n', '<leader>fs', require('telescope.builtin').current_buffer_fuzzy_find,
  { desc = "Fuzzy search current buffer" })
keymap.set('n', '<leader>fo', require('telescope.builtin').lsp_document_symbols, { desc = "Find LSP symbols" })
keymap.set('n', '<leader>fi', require('telescope.builtin').registers, { desc = "Registers" })
--keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({default_text=":method:"}) end)
-- keymap.set('n', '<leader>fm', require('telescope.builtin').treesitter, {})
keymap.set('n', '<leader>fm', require('telescope.builtin').marks, { desc = "Find marks" })
keymap.set('n', '<leader>fj', require('telescope.builtin').jumplist, { desc = "Browse jumplist" })
--keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, {})
-- keymap.set('n', '<leader>fw', function() require('telescope.builtin').current_buffer_fuzzy_find{default_text = vim.fn.expand("<cword>")} end)
keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = "Resume last picker" })
keymap.set('n', '<leader>fn', require('telescope').extensions.neoclip.default, { desc = "Find in clipboard history" })
keymap.set('n', '<leader>ft', require('telescope.builtin').tagstack, { desc = "Browse tagstack" })
keymap.set('n', '<leader>fq', require('telescope.builtin').quickfix, { desc = "Search quickfix list" })
keymap.set("n", '<leader>fd', function() require('telescope.builtin').diagnostics({ bufnr = 0 }) end,
  { desc = "Diagnostics current buffer" })

-- local floating_win = -1
-- local floating_height = 50
-- local floating_width = 100

-- local close_floating = function(_)
--     if vim.api.nvim_win_is_valid(floating_win) then
--         vim.api.nvim_win_close(floating_win, false)
--         floating_win = -1
--     end
-- end

-- local focus_floating = function(_)
--     if vim.api.nvim_win_is_valid(floating_win) then
--         vim.api.nvim_set_current_win(floating_win)
--     end
-- end

-- local open_floating = function()
--     close_floating({})
--     floating_win = vim.api.nvim_open_win(0, true,
--         {
--             relative = "win",
--             row = 50,
--             col = 100,
--             width = floating_width,
--             height = floating_height,
--             border = "rounded",
--             anchor =
--             "SW"
--         })
-- end


-- local wrapper_floating = function(opts)
--     open_floating()
--     return require('telescope.builtin').lsp_definitions(opts)
-- end

local wrapper = function(_)
  local lookup = {
    ["t"] = "tab split",
    ["s"] = "split",
    ["v"] = "vsplit",
  }
  local opts = { reuse_win = false }
  local user_input = vim.fn.input("[tab, split, vsplit]: ")
  if user_input ~= "" then
    vim.cmd(lookup[user_input])
    -- opts.jump_type = lookup[user_input]
  end
  return require('telescope.builtin').lsp_definitions(opts)
end

-- Floating window management
-- keymap.set('n', '<leader>wc', close_floating, {})
-- keymap.set('n', '<leader>wf', focus_floating, {})
-- keymap.set('n', '<leader>wo', wrapper_floating, {})

local current_buffer = function(_)
  vim.print(vim.fn.expand("%:p"))
end
keymap.set('n', '<leader>wp', current_buffer, {})

-- Remote management
keymap.set('n', '<leader>rp', '<cmd>silent !~/script/rsync_push<CR>')
keymap.set('n', '<leader>rg', '<cmd>silent !~/script/rsync_get<CR>')

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
-- keymap.set('i', '<C-o>', accept_word, {})
-- keymap.set('i', '<C-k>', accept_line, {})
-- keymap.set('i', '<C-i>', clear_suggestion, {})
keymap.set('v', '<leader>cc', '<cmd>CopilotChatToggle<CR>', { desc = "Toggle Copilot Chat" })
keymap.set('v', '<leader>ce', '<cmd>CopilotChatExplain<CR>', { desc = "Explain selected code" })
keymap.set('v', '<leader>cd', '<cmd>CopilotChatDocs<CR>', { desc = "Generate docs for selection" })
-- keymap.set('v', '<leader>cf', '<cmd>CopilotChatFix<CR>', { desc = "Fix selected code" })
keymap.set('n', '<leader>cc', '<cmd>CopilotChatToggle<CR>', { desc = "Toggle Copilot Chat" })

keymap.set('n', '<leader>cf', function()
  require("CopilotChat").ask("#diagnostics\n#buffer\nFix the errors and warnings please", {
    selection = require("CopilotChat.select").buffer,
  })
end, { desc = "Fix buffer" })

keymap.set('n', '<leader>cb', function()
  require("CopilotChat").toggle({
    sticky = { "#buffer" }
  })
end, { desc = "Ask about buffer" })

-- LSP
-- keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>')
keymap.set('n', '<leader>gd', wrapper, { desc = "Go to definition" })
keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "Go to declaration" })
keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "Go to implementation" })
keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "Go to type definition" })
keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references, { desc = "Find references" })
-- keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Show signature help" })
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "Rename symbol" })
keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "Format document" })
keymap.set('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "Format selection" })
keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "Code actions" })
keymap.set('v', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "Code actions" })
keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Show diagnostics" })
keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = "Previous diagnostic" })
keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = "Next diagnostic" })
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', { desc = "Document symbols" })
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>', { desc = "Trigger completion" })


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

-- Quickfix stuff
keymap.set("n", "<leader>qa", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lnum = vim.fn.line(".")
  local col = vim.fn.col(".")
  local text = vim.api.nvim_get_current_line()
  vim.fn.setqflist({ { bufnr = bufnr, lnum = lnum, col = col, text = text } }, "a")
end)

keymap.set("n", "<leader>qs", function()
  vim.fn.setqflist({})
end)

-- Add all diagnostics from the current buffer to quickfix list
keymap.set('n', '<leader>dq', '<cmd>lua vim.fn.setqflist(vim.diagnostic.toqflist(vim.diagnostic.get(0)))<CR>')
keymap.set('n', '<M-j>', '<cmd>cnext<CR>zz')
keymap.set('n', '<M-k>', '<cmd>cprev<CR>zz')

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
keymap.set("n", '<leader>dd', function()
  require('dap').disconnect(); require('dapui').close();
end)
keymap.set("n", '<leader>dt', function()
  require('dap').terminate(); require('dapui').close();
end)
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
keymap.set("n", '<leader>d?',
  function()
    local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
  end)
keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
-- keymap.set("n", '<leader>de',
--   function() require('telescope.builtin').diagnostics({ default_text = ":E:", bufnr = 0 }) end)
keymap.set("n", "<leader>du", "<cmd>lua require'dap'.run_to_cursor()<cr>")
keymap.set("n", "<leader>dz", "<cmd>lua require'dapui'.toggle({reset = true})<cr>")

vim.cmd("ca naw noa w")
