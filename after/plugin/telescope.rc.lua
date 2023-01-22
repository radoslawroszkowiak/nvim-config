local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')

local fb_actions = require "telescope".extensions.file_browser.actions
local lga_actions = require("telescope-live-grep-args.actions")

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
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {}
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    }
  },
}
telescope.load_extension("coc")
telescope.load_extension("file_browser")
telescope.load_extension("ui-select")
telescope.load_extension("node_modules")
telescope.load_extension("dap")
telescope.load_extension("live_grep_args")
