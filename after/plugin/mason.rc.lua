local status, mason = pcall(require, "mason")
local status_dap, mason_dap = pcall(require, "mason-nvim-dap")
if (not status) then return end

local path = vim.fn.stdpath('data') .. "/" .. "mason"

mason.setup()
mason_dap.setup({
  install_root_dir = path,
})
