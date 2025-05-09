vim.g.kitty_navigator_no_mappings = 1

-- vim.api.nvim_set_keymap('n', '<C-l>', ':KittyNavigateLeft<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-j>', ':KittyNavigateDown<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-k>', ':KittyNavigateUp<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-h>', ':KittyNavigateRight<CR>', { noremap = true, silent = true })

 vim.cmd([[
    noremap <silent> <c-h> :<C-U>KittyNavigateLeft<cr>
    noremap <silent> <c-l> :<C-U>KittyNavigateRight<cr>
    noremap <silent> <c-j> :<C-U>KittyNavigateDown<cr>
    noremap <silent> <c-k> :<C-U>KittyNavigateUp<cr>
  ]])
