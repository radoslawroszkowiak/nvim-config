local status, neotest = pcall(require, "neotest")
if (not status) then return end

neotest.setup({
  icons = {
    expanded = "",
    child_prefix = "",
    child_indent = "",
    final_child_prefix = "",
    non_collapsible = "",
    collapsed = "",

    passed = "",
    running = "",
    failed = "",
    unknown = ""
  },
  adapters = {
    require('neotest-python')({
        -- Extra arguments for nvim-dap configuration
        -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
        dap = { justMyCode = false },
        -- Command line arguments for runner
        -- Can also be a function to return dynamic values
        args = {"--log-level", "DEBUG"},
        -- Runner to use. Will use pytest if available by default.
        -- Can be a function to return dynamic value.
        runner = "pytest",
        -- Custom python path for the runner.
        -- Can be a string or a list of strings.
        -- Can also be a function to return dynamic value.
        -- If not provided, the path will be inferred by checking for 
        -- virtual envs in the local directory and for Pipenev/Poetry configs
        python = ".venv/bin/python"
        -- Returns if a given file path is a test file.
        -- NB: This function is called a lot so don't perform any heavy tasks within it.
        -- is_test_file = function(file_path)
        -- end,
    }),
    require('neotest-jest')({
      jestCommand = "npm test --",
      jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  }
})

vim.keymap.set('n', '<leader>cc', function()
  neotest.summary.open()
  neotest.run.run()
end
)
vim.keymap.set('n', '<leader>fc', function()
  neotest.summary.open()
  neotest.run.run(vim.fn.getcwd())
end
)

vim.keymap.set('n', '<leader>cd', function()
  neotest.summary.open()
  neotest.run.run({ strategy = 'dap' })
end
)

vim.keymap.set('n', '<leader>fc', function()
  neotest.summary.open()
  neotest.run.run(vim.fn.expand("%"))
end
)
vim.keymap.set('n', '<leader>fd', function()
  neotest.summary.open()
  neotest.run.run({ vim.fn.expand("%"), strategy = 'dap' })
end
)

vim.keymap.set('n', '<leader>cs', neotest.run.stop)

vim.keymap.set('n', '<A-6>', neotest.summary.toggle)
