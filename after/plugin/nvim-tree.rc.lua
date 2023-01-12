local status, nvimTree = pcall(require, "nvim-tree")
if (not status) then return end

nvimTree.setup({
  sort_by = "case_sensitive",
  open_on_setup = true,
  open_on_setup_file = true,
  view = {
    adaptive_size = true,
    side = "left",
    mappings = {
      list = {
        { key = "<S-F6>", action = "rename" },
        { key = { "l", "<CR>", "o" }, cb = ":lua require'nvim-tree'.on_keypress('edit')<CR>" },
        { key = "h", cb = ":lua require'nvim-tree'.on_keypress('close_node')<CR>" },
        { key = "v", cb = ":lua require'nvim-tree'.on_keypress('vsplit')<CR>" },
        { key = "s", cb = ":lua require'nvim-tree'.on_keypress('split')<CR>" },
        { key = "t", cb = ":lua require'nvim-tree'.on_keypress('tabnew')<CR>" },
        { key = "<C-t>", cb = ":lua require'nvim-tree'.on_keypress('tabnew')<CR>" },
        { key = "<", cb = ":lua require'nvim-tree'.on_keypress('prev_sibling')<CR>" },
        { key = ">", cb = ":lua require'nvim-tree'.on_keypress('next_sibling')<CR>" },
        { key = "P", cb = ":lua require'nvim-tree'.on_keypress('parent_node')<CR>" },
        { key = "<BS>", cb = ":lua require'nvim-tree'.on_keypress('close_node')<CR>" },
        { key = "<S-CR>", cb = ":lua require'nvim-tree'.on_keypress('close_node')<CR>" },
        { key = "<Tab>", cb = ":lua require'nvim-tree'.on_keypress('preview')<CR>" },
        { key = "K", cb = ":lua require'nvim-tree'.on_keypress('first_sibling')<CR>" },
        { key = "J", cb = ":lua require'nvim-tree'.on_keypress('last_sibling')<CR>" },
        { key = "I", cb = ":lua require'nvim-tree'.on_keypress('toggle_ignored')<CR>" },
        { key = "H", cb = ":lua require'nvim-tree'.on_keypress('toggle_dotfiles')<CR>" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = {},
  },
  git = {
    ignore = false
  },
  filters = {
    dotfiles = false,
    custom = {
      "\\.git/",
      "\\.devcontainer",
      "\\.vscode",
      "\\.history",
      "\\.idea",
      "\\.*.iml",
      "__pycache__",
      "\\.pytest_cache",
    }
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    debounce_delay = 300,
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 300,
    ignore_dirs = { "node_modules", ".git", ".cache", ".history", ".idea", ".vscode", "build", ".build", "dist", "__pycache__", "coverage", "jest-stare" },
  }
})
