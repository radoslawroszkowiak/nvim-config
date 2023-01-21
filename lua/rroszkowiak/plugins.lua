local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

ensure_packer()

local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

packer.startup(function(use)
  use 'olimorris/onedarkpro.nvim'
  -- use { "ellisonleao/gruvbox.nvim" }
  vim.cmd('colorscheme onedark')
  --vim.cmd('colorscheme gruvbox')
  use 'kyazdani42/nvim-web-devicons' -- File icons


  use 'wbthomason/packer.nvim'
  use 'nvim-lualine/lualine.nvim' -- Statusline

  use 'mhinz/vim-startify' -- Start screen

  -- File explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    }
  }

  use 'akinsho/toggleterm.nvim'

  use 'williamboman/mason.nvim'
  -- use 'onsails/lspkind-nvim' -- vscode-like pictograms
  -- use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  -- use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
  -- use 'neovim/nvim-lspconfig' -- LSP
  -- use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua

  -- use 'glepnir/lspsaga.nvim' -- LSP UIs
  -- use 'L3MON4D3/LuaSnip'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  use 'lukas-reineke/indent-blankline.nvim'

  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'nvim-telescope/telescope-node-modules.nvim'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'nvim-telescope/telescope-live-grep-args.nvim'

  use 'fannheyward/telescope-coc.nvim' -- Coc integration for telescope
  use 'nvim-lua/plenary.nvim' -- Common utilities, need for telescope
  use 'antoinemadec/FixCursorHold.nvim'

  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use { 'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    }
  }
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/todo-comments.nvim' -- Highlight TODOs, FIXMEs, etc



  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  use 'nvim-pack/nvim-spectre'

  use 'akinsho/nvim-bufferline.lua'
  use 'github/copilot.vim'

  use 'lewis6991/gitsigns.nvim'
  use 'kdheepak/lazygit.nvim'
  use 'tpope/vim-fugitive'

  -- "IDE stuff"
  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }
  use 'neoclide/coc-tsserver'
  use 'neoclide/coc-css'
  use 'neoclide/coc-html'
  use 'neoclide/vim-jsx-improve'

  use {
    'nvim-neotest/neotest',
    requires = {
      'nvim-neotest/neotest-python',
      'haydenmeade/neotest-jest'
    }
  }

  use 'neoclide/coc-eslint'
  use 'sbdchd/neoformat'

  -- undotree
  use 'mbbill/undotree'

  -- use 'jiaoshijie/undotree'

  -- Debugging
  use {
    'mfussenegger/nvim-dap',
    requires = {
      'mxsdev/nvim-dap-vscode-js',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'jayp0521/mason-nvim-dap.nvim',
      'rcarriga/cmp-dap'
    }
  }
end)
