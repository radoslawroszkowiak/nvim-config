vim.g.mapleader = "\\"
vim.keymap.set("n", "\\", "<Nop>", { silent = true })

local keymap = vim.keymap

keymap.set('i', 'ii', '<Esc>', { noremap = true })
keymap.set('n', '<esc>', ':noh<cr>')

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
keymap.set('v', '<Tab>', '>gv', { noremap = false })
keymap.set('v', '<S-Tab>', '<gv', { noremap = false })


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
keymap.set('n', '<C-f>', function()
  telescope_builtin.live_grep()
end, { noremap = true })
keymap.set('n', '\\\\', function()
  telescope_builtin.buffers()
end)
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

keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', { silent = true, noremap = true })
keymap.set('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)gv', { silent = true, noremap = true })
