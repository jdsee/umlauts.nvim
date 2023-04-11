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
    vim.keymap.set("i", lhs, rhs)
  end
end

M.disable_umlaut_mappings = function()
  for lhs, _ in pairs(mappings) do
    pcall(vim.keymap.del, "i", lhs)
  end
end

M.setup = function(opts)
  local autocommands = require "umlauts.autocommands"
  local defaults = require "umlauts.defaults"
  local extended_opts = vim.tbl_deep_extend('force', opts, defaults)
  autocommands.setup(extended_opts)
end

return M
