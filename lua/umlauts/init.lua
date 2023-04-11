local M = {}

local mappings = {
  Ae = "Ä",
  Oe = "Ö",
  Ue = "Ü",
  ae = "ä",
  oe = "ö",
  ue = "ü",
  sz = "ß",
}

M.enable_umlaut_mappings = function()
  for lhs, rhs in pairs(mappings) do
    vim.keymap.set("i", lhs, rhs, { buffer = true })
  end
end

M.disable_umlaut_mappings = function()
  for lhs, _ in pairs(mappings) do
    pcall(vim.keymap.del, "i", lhs, { buffer = true })
  end
end

M.setup = function(opts)
  local autocmds = require "umlauts.autocmds"
  local usercmds = require "umlauts.usercmds"
  local defaults = require "umlauts.defaults"
  local extended_opts = vim.tbl_deep_extend('force', opts or {}, defaults)
  autocmds.setup(extended_opts)
  usercmds.setup()
end

return M
