local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      ".git/",
      ".cache",
      ".DS_Store",
      ".history",
      ".idea",
      ".vscode",
      "build",
      ".build",
      "dist",
      "__pycache__",
      "coverage",
      "jest-stare",
    },
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    coc = {
        theme = 'ivy',
        prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
    },
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}
telescope.load_extension('coc')
telescope.load_extension("file_browser")