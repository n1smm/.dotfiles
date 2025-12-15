------------------------------------------------------------
-- LSP CONFIG (Neovim 0.11+, no deprecated APIs)
------------------------------------------------------------

-- mason
require("mason").setup()

-- mason-lspconfig
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "clangd",
    "cmake",
    "cssls",
    "html",
    "jsonls",
    "pyright",
    "rust_analyzer",
    "lua_ls",
    "ts_ls",
    "vimls",
    "yamlls",
    "typos_lsp",
    "sqlls",
    "emmet_ls",
    "solidity_ls",
  },
})

------------------------------------------------------------
-- on_attach (explicit, minimal, correct)
------------------------------------------------------------
local function on_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  if client.supports_method("textDocument/formatting") then
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end
end

------------------------------------------------------------
-- capabilities (nvim-cmp stays unchanged)
------------------------------------------------------------
local capabilities =
  require("cmp_nvim_lsp").default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

------------------------------------------------------------
-- default config for ALL servers
------------------------------------------------------------
vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = on_attach,
})

------------------------------------------------------------
-- Server-specific overrides
------------------------------------------------------------

-- Lua
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- HTML (extra filetypes)
vim.lsp.config("html", {
  filetypes = { "html", "ejs" },
})

-- Solidity
vim.lsp.config("solidity_ls", {
  filetypes = { "solidity" },
  root_dir = require("lspconfig.util").root_pattern(
    "truffle-config.js",
    "hardhat.config.js",
    "package.json",
    ".git"
  ),
})

-- Arduino
vim.lsp.config("arduino_language_server", {
  cmd = {
    "arduino-language-server",
    "/home/thiew/go/bin/arduino-language-server",
    "-clangd", "/usr/bin/clangd",
    "-cli", "/home/thiew/.local/bin/arduino-cli",
    "-cli-config", "/home/thiew/.arduino15/arduino-cli.yaml",
    "-fqbn", "arduino:avr:uno",
  },
  filetypes = { "arduino" },
})

------------------------------------------------------------
-- Enable servers
------------------------------------------------------------
for _, server in ipairs({
  "bashls",
  "clangd",
  "cmake",
  "cssls",
  "html",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "lua_ls",
  "ts_ls",
  "vimls",
  "yamlls",
  "typos_lsp",
  "sqlls",
  "emmet_ls",
  "solidity_ls",
  "arduino_language_server",
}) do
  pcall(vim.lsp.enable, server)
end

