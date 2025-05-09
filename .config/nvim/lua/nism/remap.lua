--leader set = space
vim.g.mapleader = " "

--open netrw explorer in window ; EXplorer = ex
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
--toggle netrw as side window ; Explorer to Side = es
vim.keymap.set("n", "<leader>es", vim.cmd.Lexplore)
-- change directory to current file in netrw
vim.keymap.set("n", "<leader>cd", '<cmd>lcd %:p:h<CR>')

--switch from normal to relative numbering
vim.api.nvim_set_keymap('n', '<F6>', ':lua ToggleRelNumber()<CR>', { noremap = true, silent = true })

-- insert befbitwig live syncore 1 char = ctr + i
--vim.api.nvim_set_keymap('n', '<C-i>', 'i_<Esc>r', { noremap = true })

-- insert after 1 char = ctr + a
-- vim.api.nvim_set_keymap('n', '<C-a>', 'a_<Esc>r', { noremap = true })

--copy/past to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')

--split window ; Vertical Split = vs ; Horizontal Split = hs
vim.keymap.set("n", "<leader>vs", vim.cmd.vsp)
vim.keymap.set("n", "<leader>hs", vim.cmd.sp)

--writing and quitting ; Writeall = ww ; Write and Quit = wq; force quit = qf
vim.keymap.set('n', '<leader>wq', '<cmd>lua WriteQuit()<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ww", vim.cmd.wall)
vim.keymap.set("n", "<leader>fq", '<cmd>lua ForceQuit()<CR>')

--sudo write
vim.api.nvim_set_keymap('n', '<leader>ws', ':lua SudoWrite()<CR>', { noremap = true, silent = true })

-- switch windows ; w = Window hjkl= direction
-- vim.keymap.set("n", "<leader>wl", '<C-w>l')
-- vim.keymap.set("n", "<leader>wh", '<C-w>h')
-- vim.keymap.set("n", "<leader>wj", '<C-w>j')
-- vim.keymap.set("n", "<leader>wk", '<C-w>k')
--resize windows ; Window Resize = wr ; Window Maximize = wm
vim.keymap.set("n", "<leader>wr", '<C-w>=')
vim.keymap.set("n", "<leader>wm", '<C-w>|')

--clear highlight of / search ; vb = Visual Bell
vim.keymap.set("n", "<leader>vb", vim.cmd.noh)

-- EXTERNAL PLUGINS KEYBINDS

--lazygit mapping
vim .keymap.set("n", "<leader>lg", vim.cmd.LazyGit)

--rest console mapping
vim.keymap.set("n", "<leader>rc", ":call VrcQuery()<CR>")

-- toggle auto-save
vim.api.nvim_set_keymap("n", "<leader>as", ":ASToggle<CR>", {})

--exit insert mode
vim.keymap.set("i", "<A-n>", '<C-c>')

--floating cmd line
-- vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})
vim.keymap.set('n', '<leader>s', ':SearchBoxIncSearch<CR>')

vim.keymap.set('n', '<leader>so', ':source $MYVIMRC<CR>', {noremap = true})


--change the background color for this session
vim.keymap.set('n', '<leader>bg', ':lua Set_background_color()<CR>', {noremap = true})

-- KEYBINDS OF OTHER PLUGINS
--
-- <leader>gs = git search (fugitive)
-- <leader>u  = Undotree toggle (UndoTree)
-- harpoon
-- <leader>a = add file to quick menu
-- control + e = toggle quick menu
-- alt + 1,2,3,4 = switch to 1st,2nd,3rd,4th saved window
--telescope - fzf engine
-- <leader>ff = Find Files
-- <leader>fg = Find Git files
-- <leader>fw = Find Word (uses ripgrep)
