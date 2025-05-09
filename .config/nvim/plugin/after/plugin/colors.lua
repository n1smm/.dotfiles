function ColorTransparent(color)
	color = color or "melange"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	vim.api.nvim_set_hl(0, "StatusLine", { bg = '#2c1608' })
end

ColorTransparent()
