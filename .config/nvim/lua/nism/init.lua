require("nism.remap")
require("nism.set")
require("nism.todolight")
require('plugish')
require('plugish').setup()
vim.opt.termguicolors = true
vim.cmd.colorscheme 'melange'
--require("lspconfig").lua_ls.setup({})
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}

vim.api.nvim_set_keymap('n', '<leader>fn', ':lua require("plugish").search_functions()<CR>', { noremap = true, silent = true })
