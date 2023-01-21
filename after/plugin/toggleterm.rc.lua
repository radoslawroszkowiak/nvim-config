local toggleterm = require('toggleterm')

toggleterm.setup({
  persist_size = true,
  persist_mode = true,
  direction = 'horizontal',
  close_on_exit = true,
  auto_scroll = true,
  start_in_insert = true,
  hide_numbers = true,
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})
