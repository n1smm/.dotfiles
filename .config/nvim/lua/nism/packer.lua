
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself

  use '~/.config/nvim/newplug'

  use 'wbthomason/packer.nvim'

  ----------- MUST HAVE PLUGINS ----------------

  -- telescope - fzf for nvim
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.6',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
	  "nvim-telescope/telescope-file-browser.nvim",
	  requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }
  use {
	  'nvim-telescope/telescope-ui-select.nvim',
  requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }

  -- fzf-lua
  use { "ibhagwan/fzf-lua",
  requires = { "nvim-tree/nvim-web-devicons" }
  }

  -- parser generator/library for syntax highlighting etc.
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  -- lsp auto-configuration
  use {
	  'williamboman/mason.nvim',
	  commit = 'fc98833b6da5de5a9c5b1446ac541577059555be',
  }
  use {'williamboman/mason-lspconfig.nvim',
  		commit = '1a31f824b9cd5bc6f342fc29e9a53b60d74af245',
	}


  use {'neovim/nvim-lspconfig'}
  use {'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'L3MON4D3/LuaSnip'}
  use ('saadparwaiz1/cmp_luasnip')
  use ("rafamadriz/friendly-snippets")


----------- UI EXTENSIONS ----------------

  -- fast tasks/file switcher
  use('theprimeagen/harpoon')

  -- definition/references finder - good for overview of references
  use ('pechorin/any-jump.vim')

  -- undo history
  use('mbbill/undotree')
  -- git management
  use('tpope/vim-fugitive')
  -- lazygit
  use({
	  "kdheepak/lazygit.nvim",
	  -- optional for floating window border decoration
	  requires = {
		  "nvim-lua/plenary.nvim",
	  },
  })

  ----- 42-school must extensions
  use ('42Paris/42header')
  use ('cacharle/c_formatter_42.vim')

  ------ frontend development plugins ------
  --live html,css,js preview - http server
  use('turbio/bracey.vim')
  --nvim emmet
  use({'olrtg/nvim-emmet',
  	config = function()
		vim.keymap.set({"n", "v"}, "<leader>em", require('nvim-emmet').wrap_with_abbreviation)end
  })
  use('epilande/vim-react-snippets')


  --------backend, databases, etc.
  --database manager
  use('tpope/vim-dadbod')
  use('kristijanhusak/vim-dadbod-ui')
  use('kristijanhusak/vim-dadbod-completion')
  --rest client
  -- use('NTBBloodbath/rest.nvim')
  use('diepm/vim-rest-console')


  --debugger DAP
  -- use {
	  -- 'mfussenegger/nvim-dap',
	  -- requires = {
		  -- {'nvim-neotest/nvim-nio'},
		  -- {'theHamsta/nvim-dap-virtual-text'},
		  -- {'rcarriga/nvim-dap-ui'},
		  -- {'mfussenegger/nvim-dap-python'},
		  -- {'nvim-telescope/telescope-dap.nvim'},
	  -- }
  -- }


  --------- MISCELLANEOUS PLUGINS / coding environments ----------------

  --copilot
  use ('github/copilot.vim')
  --copilot chat
  use {
		  "CopilotC-Nvim/CopilotChat.nvim",
		  branch = "main",
		  dependencies = {
			  { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			  { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		  },
		  opts = {
			  debug = true, -- Enable debugging
			  -- See Configuration section for rest
		  },
		  -- See Commands section for default commands if you want to lazy load on them
  }

	  --auto save
  use({
	  "Pocco81/auto-save.nvim",
	  config = function()
		  require("auto-save").setup {
			  enabled = false,
			  -- your config goes here
			  -- or just leave it empty :)
		  }
	  end,
  })


  --arduino environment
  use {'stevearc/vim-arduino'}
  -- use {'sudar/vim-arduino-syntax'}

  --solidity
  use {'tomlion/vim-solidity'}
  -- use {'ChristianChiarulli/vim-solidity'}


  --supercolider plug
  use {'supercollider/scvim'}
  --tidalcycles
  use {'tidalcycles/vim-tidal'}





  ---------------- UI IMPROVEMENTS -----------------

  -- easy commenting
  use ('tpope/vim-commentary')

  -- prettier to the eye
  use ('MunifTanjim/nui.nvim')
  use {
	  "folke/noice.nvim",
	  opts = function(_, opts)
		  opts.present.lsp_doc_border = true
	  end,
  }
  use ('echasnovski/mini.icons')
  use ('prichrd/netrw.nvim')

  use ('VonHeikemen/fine-cmdline.nvim')
  use ('VonHeikemen/searchbox.nvim')
  use {'stevearc/dressing.nvim'}

  --ansiesc support
  use ('powerman/vim-plugin-AnsiEsc')
  -- theme
  use { "savq/melange-nvim" }

  -- folding plugin
  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

  -- colored parentheses
  use ('luochen1990/rainbow')

  --multiline editing
  use('mg979/vim-visual-multi')

  --kitty terminal integration
  use {
	  'knubie/vim-kitty-navigator',
	  run = 'cp ./*.py ~/.config/kitty/'
  }

end)
