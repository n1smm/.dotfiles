--mapping for bracey
-- -- <leader>bp = open html preview
vim.api.nvim_set_keymap('n', '<leader>bp', ':Bracey<CR>', { noremap = true, silent = true })
-- -- <leader>bc = close html preview
vim.api.nvim_set_keymap('n', '<leader>bc', ':BraceyStop<CR>', { noremap = true, silent = true })
-- -- <leader>br = refresh html preview
vim.api.nvim_set_keymap('n', '<leader>br', ':BraceyReload<CR>', { noremap = true, silent = true })
