local status, dap = pcall(require, "dap")
if (not status) then return end

local dapui = require'dapui'
local dap_virtual_text = require'nvim-dap-virtual-text'
local dap_vscode_js = require'dap-vscode-js'

dap_vscode_js.setup({
    debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
    debugger_cmd = { 'js-debug-adapter' },
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

-- custom adapter for running tasks before starting debug
local custom_adapter = 'pwa-node-custom'
dap.adapters[custom_adapter] = function(cb, config)
    if config.preLaunchTask then
        local async = require('plenary.async')
        local notify = require('notify').async

        async.run(function()
            ---@diagnostic disable-next-line: missing-parameter
            notify('Running [' .. config.preLaunchTask .. ']').events.close()
        end, function()
            vim.fn.system(config.preLaunchTask)
            config.type = 'pwa-node'
            dap.run(config)
        end)
    end
end

-- language config
for _, language in ipairs({ 'typescript', 'javascript' }) do
    dap.configurations[language] = {
        {
            name = 'Launch',
            type = 'pwa-node',
            request = 'launch',
            program = '${file}',
            rootPath = '${workspaceFolder}',
            showLog = false,
            cwd = '${workspaceFolder}',
            sourceMaps = true,
            skipFiles = { '<node_internals>/**' },
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            name = 'Attach to node process',
            type = 'pwa-node',
            request = 'attach',
            showLog = false,
            rootPath = '${workspaceFolder}',
            processId = require('dap.utils').pick_process,
        }
    }
end

dapui.setup({
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  -- expand_lines = vim.fn.has("nvim-0.7") == 1,
  expand_lines = false,
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.3 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 45, -- 45 columns
      position = "right",
    },
    {
      elements = {
        "repl",
      },
      size = 0.2, -- 20% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

dap_virtual_text.setup({
    enabled = true,
    enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,               -- show stop reason when stopped for exceptions
    commented = false,                     -- prefix virtual text with comment string
    only_first_definition = false,          -- only show virtual text at first definition (if there are multiple)
    all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
})

local function debugNpm(npmScriptName)
  print("starting debugging " .. npmScriptName)
  local handle = io.popen('which yarn')
  local path = handle:read('*a')
  handle:close()

  local trimmed_path = path:match("^%s*(.-)%s*$")

  dap.run({
      type = 'pwa-node',
      request = 'launch',
      cwd = vim.fn.getcwd(),
      runtimeArgs = {'--inspect-brk', trimmed_path, 'run', npmScriptName},
      sourceMaps = true,
      protocol = 'inspector',
      skipFiles = {'<node_internals>/**/*.js'},
      console = 'integratedTerminal',
      port = 9229,
      })
end

local function attach()
  print("attaching")
  dap.run({
      type = 'node2',
      request = 'attach',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      skipFiles = {'<node_internals>/**/*.js'},
      })
end

local function attachToRemote()
  print("attaching")
  dap.run({
      type = 'node2',
      request = 'attach',
      address = "127.0.0.1",
      port = 9229,
      localRoot = vim.fn.getcwd(),
      remoteRoot = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      skipFiles = {'<node_internals>/**/*.js'},
      })
end



local neotest = require("neotest")
dap.listeners.after.event_stopped["dapui_config"] = function()
  dapui.open()
  neotest.summary.close()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local cmp = require('cmp')
cmp.setup({
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end
})

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})


dap.defaults.fallback.terminal_win_cmd = '20split new'

vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg=0, fg='#993939', bg='#31353f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg=0, fg='#61afef', bg='#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg=0, fg='#98c379', bg='#31353f' })

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })


vim.keymap.set('n', '<leader>1', dap.continue)
vim.keymap.set('n', '<leader>2', dap.step_over)
vim.keymap.set('n', '<leader>3', dap.step_into)
vim.keymap.set('n', '<leader>4', dap.step_out)
vim.keymap.set('n', '<leader>rr', dap.repl.toggle)
vim.keymap.set('n', '<leader>8', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>d', dapui.toggle)

vim.keymap.set('n', '<leader>e', ':lua require("dapui").eval()<CR>', { noremap = true })
vim.keymap.set('v', '<leader>e', ':lua require("dapui").eval()<CR>', { noremap = true })

vim.keymap.set('n', '<leader>db', attach)
vim.keymap.set('n', '<leader>dB', attachToRemote)

vim.keymap.set('n', '<leader>55', function() 
    local scriptName = vim.fn.input('Run npm script: ', '')
    io.write('starting script... ', scriptName)
    debugNpm(scriptName)
end
)

