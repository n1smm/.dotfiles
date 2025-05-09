require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}
vim.g.copilot_filetypes = {
['*'] = false,
['javascript'] = true,
['typescript'] = true,
['vue'] = true,
['lua'] = true,
['html'] = true,
['css'] = true,
['jsx'] = true,
['tsx'] = true,
['scss'] = true,
['sass'] = true,
['less'] = true,
['json'] = true,
['yaml'] = true,
['markdown'] = true,
['python'] = true,
-- ['c'] = true,
-- ['cpp'] = true,
['java'] = true,
['rust'] = true,
['go'] = true,
['ruby'] = true,
['php'] = true,
['shell'] = true,
-- ['vim'] = true,
['dockerfile'] = true,
-- ['plaintext'] = true,
['sql'] = true,
['graphql'] = true,
['graphqls'] = true,
['arduino'] = true,
} 

vim.keymap.set("n", "<leader>co", vim.cmd.CopilotToggle)
