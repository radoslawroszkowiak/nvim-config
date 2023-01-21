vim.g.mapleader = "\\"
vim.keymap.set("n", "\\", "<Nop>", { silent = true })

local keymap = vim.keymap

keymap.set('i', 'ii', '<Esc>', { noremap = true })
keymap.set('n', '<esc>', ':noh<cr>', { silent = true })
keymap.set('v', '<esc>', '<C-c>', { silent = true })

keymap.set('c', 'W', 'w', { noremap = true })
keymap.set('c', 'Q', 'q', { noremap = true })

-- New tab
keymap.set('n', 'te', ':tabedit')
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')

-- Resize window
keymap.set('n', '<C-h>', '<C-w><')
keymap.set('n', '<C-l>', '<C-w>>')
keymap.set('n', '<C-k>', '<C-w>+')
keymap.set('n', '<C-j>', '<C-w>-')

-- Navigate between panes
keymap.set('n', '<A-k>', ':wincmd k<CR>', { silent = true, noremap = false })
keymap.set('n', '<A-j>', ':wincmd j<CR>', { silent = true, noremap = false })
keymap.set('n', '<A-h>', ':wincmd h<CR>', { silent = true, noremap = false })
keymap.set('n', '<A-l>', ':wincmd l<CR>', { silent = true, noremap = false })

-- File explorer
keymap.set("n", "<A-1>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
keymap.set("n", "<A-3>", ":LazyGit<CR>", { noremap = true, silent = true })
keymap.set("n", "<A-8>", ":LazyGitFilterCurrentFile<CR>", { noremap = true, silent = true })
keymap.set("n", "<A-7>", ":Telescope coc workspace_symbols<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { noremap = true, silent = true })
keymap.set("n", "<A-0>", ":Telescope coc workspace_diagnostics<CR>", { noremap = true, silent = true })

-- Indentation
keymap.set('v', '<C-]>', '>gv', { noremap = false, silent = true })
keymap.set('v', '<C-[>', '<gv', { noremap = false, silent = true })

keymap.set("n", "<leader>qr", ":Telescope coc references<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>qd", ":Telescope coc definitions<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>q0", ":Telescope coc diagnostics<CR>", { noremap = true, silent = true })


local status, telescope = pcall(require, "telescope")
if (not status) then return end
local telescope_builtin = require("telescope.builtin")

keymap.set('n', '<C-n>',
  function()
    telescope_builtin.find_files({
      no_ignore = false,
      hidden = true
    })
  end)
local spectre = require('spectre')
keymap.set('n', '<A-r>', spectre.open)
keymap.set('n', ';r', function()
  -- telescope_builtin.live_grep()
  telescope.extensions.live_grep_args.live_grep_args()
end, { noremap = true })
keymap.set('n', '\\\\', ':Telescope coc workspace_symbols<CR>')
keymap.set('n', ';t', function()
  telescope_builtin.help_tags()
end)
keymap.set('n', ';;', function()
  telescope_builtin.resume()
end)
keymap.set('n', ';e', function()
  telescope_builtin.diagnostics()
end)

keymap.set('n', '<A-b>', function()
  telescope_builtin.git_branches()
end)
keymap.set('n', '<A-u>', function()
  telescope_builtin.git_stash()
end)
keymap.set('n', '<A-s>', ':Git stash<cr>', {noremap = true})
keymap.set('n', '<A-a>', ":Git blame<cr>", {noremap = true})
keymap.set('n', '<A-f>', ":Neoformat<cr>", {noremap = true})
keymap.set('v', '<A-f>', ":Neoformat<cr>", {noremap = true})
keymap.set('n', '<A-t>', ":ToggleTerm direction=horizontal<cr>", {noremap = true})
keymap.set('n', '<A-y>', ":ToggleTerm direction=float<cr>", {noremap = true})
keymap.set('n', '<A-u>', ":ToggleTermToggleAll<cr>", {noremap = true})
keymap.set('t', '<esc>', '<C-\\><C-n>', {noremap = true})
keymap.set('t', '<A-t>', '<C-\\><C-n>:ToggleTerm<cr>', {noremap = true})
keymap.set('t', '<A-y>', '<C-\\><C-n>:ToggleTerm direction=horizontal<cr>', {noremap = true})
keymap.set('t', '<A-y>', '<C-\\><C-n>:ToggleTerm direction=float<cr>', {noremap = true})
keymap.set('t', '<A-u>', '<C-\\><C-n>:ToggleTermToggleAll<cr>', {noremap = true})

keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', { silent = true, noremap = true })
keymap.set('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)gv', { silent = true, noremap = true })
