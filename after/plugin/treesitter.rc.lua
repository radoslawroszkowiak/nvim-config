local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    enabled = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "javascript",
    "tsx",
    "typescript",
    "toml",
    "php",
    "python",
    "json",
    "yaml",
    "swift",
    "css",
    "html",
    "lua",
    "vim"
  },
  autotag = {
    enable = true,
  },
}

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    enabled = true,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "typescript", "tsx" }

require('treesitter-context').setup()
