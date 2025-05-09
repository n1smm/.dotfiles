vim.g.user = "n1smm"
vim.g.mail = "tjaz.juvan@gmail.com"

--setting copy paste TODO (not working properly)
vim.api.nvim_set_option("clipboard","unnamed")

-- Better command-line completion
vim.o.wildmenu = true

-- Show partial commands in the last line of the screen
vim.o.showcmd = true

-- Highlight searches (use <C-L> to temporarily turn off highlighting)
-- Commented out as Lua doesn't directly support this feature

-- Use case insensitive search, except when using capital letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Allow backspacing over autoindent, line breaks, and start of insert action
vim.o.backspace = 'indent,eol,start'

-- Keep the same indent as the current line when opening a new line
vim.o.autoindent = true
vim.o.smartindent = true

-- Stop certain movements from always going to the first character of a line
vim.o.startofline = false

-- Display the cursor position on the last line of the screen or in the status line
vim.o.ruler = true

-- Always display the status line, even if only one window is displayed
vim.o.laststatus = 2

-- Instead of failing a command because of unsaved changes, raise a dialogue asking to save
vim.o.confirm = true

-- Use visual bell instead of beeping when doing something wrong
vim.o.visualbell = true

-- Reset the terminal code for the visual bell
-- vim.o.t_vb = ''

-- Enable filetype plugins
vim.cmd('filetype plugin on')

-- Enable filetype indent settings
vim.cmd('filetype indent on')

-- Set the width of an indentation level to 4 spaces
vim.o.shiftwidth = 4

-- Set the width of a tab character to 4 spaces
vim.o.tabstop = 4

-- Use actual tab characters instead of spaces when indenting
vim.o.expandtab = false

--vim rest console
vim.g.vrc_show_command = 1
vim.g.vrc_show_response = 1
vim.g.vrc_show_headers = 1
vim.g.vrc_show_body = 1
vim.g.vrc_show_status = 1


--color of statusline
vim.cmd('highlight StatusLine guibg=#2c1608')


-- Disable automatic comment continuation on a new line
vim.api.nvim_exec([[
  augroup DisableAutoComment
    autocmd!
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  augroup END
]], false)

-- FUNCTIONS --
--numbers
vim.opt.number = true
vim.o.relativenumber = true
function ToggleRelNumber()
    if vim.o.relativenumber then
        vim.o.relativenumber = false
    else
        vim.o.relativenumber = true
   end
end

--set background color
local has_bg = false
function Set_background_color()
	if (has_bg) then
		vim.cmd('set background=dark')
		vim.cmd.colorscheme("melange")

		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

		vim.api.nvim_set_hl(0, "StatusLine", { bg = '#2c1608' })
		has_bg = false
	else
		vim.cmd('set background=light')
		vim.api.nvim_set_hl(0, "Normal", { bg = '#8ff2bd' })
		vim.cmd.colorscheme("melange")
		has_bg = true
	end
end

--write n quit
function WriteQuit()
	vim.cmd('w')
	vim.cmd('q')
end

--force quit
function ForceQuit()
	vim.cmd('q!')
end

function SudoWrite()
    if vim.fn.expand("%") == "" then
        print("No file to write.")
        return
    end

    local file_path = vim.fn.expand("%:p")
    local tmp_file = vim.fn.tempname()

    -- Write to a temporary file
    vim.cmd("write! " .. tmp_file)

    -- Construct the sudo command
    local cmd = string.format("sudo -S mv %s %s", tmp_file, file_path)

    -- Execute the command
    local password = vim.fn.inputsecret("Password: ")
    local handle = io.popen("echo \"" .. password .. "\" | " .. cmd)
    handle:close()

    -- Notify the user
    print("File saved with sudo permissions.")
end

-- 5108: Error executing lua [string ":source (no file)"]:2: loop or previous error loading module 'nism.
-- set'                                                                                                   
-- stack traceback:                                                                                       
--     [C]: in function 'require'                                                                         
--     [string ":source (no file)"]:2: in main chunk                                                      
--     [C]: in function 'nvim_exec2'                                                                      
--     vim/_editor.lua: in function <vim/_editor.lua:0>                                                   
--     [C]: in function 'pcall'                                                                           
--     ...packer/start/fine-cmdline.nvim/lua/fine-cmdline/init.lua:98: in function <...packer/start/fine-c
-- mdline.nvim/lua/fine-cmdline/init.lua:94>                                                              
--     [C]: in function 'pcall'                                                                           
--     ...packer/start/fine-cmdline.nvim/lua/fine-cmdline/init.lua:65: in function 'on_submit'            
--     ...m/site/pack/packer/start/nui.nvim/lua/nui/input/init.lua:162: in function <...m/site/pack/packer
-- /start/nui.nvim/lua/nui/input/init.lua:149>       
