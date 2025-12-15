if vim.fn.has("nvim-0.5") == 0 then return end

local ok, mod = pcall(require, "todoIndex")
if ok and type(mod.setup) == "function" then
  mod.setup()
end
