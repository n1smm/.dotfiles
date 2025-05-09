local extract_functions = require('extract_functions')
-- local utils = require('utils')

local augroup = vim.api.nvim_create_augroup("plugish", {clear = true})
-- vim.api.augroup_set( augroup, {
--   {"FileType", "*", "lua require('plugish').load_plugins()"},
--   {"FileType", "*", "lua require('plugish').load_config()"},
-- })
--

local function main()
	--for now just displays functions recursively in all .c files
	extract_functions.display_functions()
	-- find_functions.extract_functions()
end

local function setup()
	vim.api.nvim_create_autocmd("VimEnter", {
		group = augroup,
		pattern = "*.c",
		desc = "plugish",
		once = true,
		callback = main
	})
	-- vim.keymap.set("n", "<leader>pf", ':lua require("plugish").setup()<CR>', { noremap = true, silent = true })
end

	return {
		setup = setup
		-- load_plugins = load_plugins,
		-- load_config = load_config,
	}
