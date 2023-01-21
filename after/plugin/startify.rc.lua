
  vim.g.startify_lists = {
    { type = 'sessions', header = {' Sessions'} },
    { type = 'dir', header = {' Files ' .. vim.fn.getcwd()} },
    { type = 'bookmarks', header = {' Bookmarks'} },
    { type = 'commands', header = {' Commands'} }
  }
