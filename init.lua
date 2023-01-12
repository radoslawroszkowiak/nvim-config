require('rroszkowiak.base')
require('rroszkowiak.highlights')
require('rroszkowiak.maps')
require('rroszkowiak.plugins')

local has = vim.fn.has
local is_mac = has "macunix"
local is_win = has "win32"

if is_mac then
  require('rroszkowiak.macos')
end
if is_win then
  require('rroszkowiak.windows')
end
