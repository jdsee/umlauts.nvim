local M = {}

local defaults = require "umlauts.defaults"

M._state = {
  enabled = false,
}

M.enable_umlaut_mappings = function()
  if M._state.enabled then return end
  M._state.enabled = true
  for lhs, rhs in pairs(defaults.mappings) do
    vim.keymap.set("i", lhs, rhs, { buffer = true })
  end
end

M.disable_umlaut_mappings = function()
  if not M._state.enabled then return end
  M._state.enabled = false
  for lhs, _ in pairs(defaults.mappings) do
    pcall(vim.keymap.del, "i", lhs, { buffer = true })
  end
end

M.toggle_umlaut_mappings = function()
  if (M._state.enabled) then
    M.disable_umlaut_mappings()
  else
    M.enable_umlaut_mappings()
  end
end



M.setup = function(opts)
  local extended_opts = vim.tbl_deep_extend('force', opts or {}, defaults)

  M._state = {
    enabled = false,
    mappings = extended_opts.mappings
  }

  require("umlauts.autocmds").setup(extended_opts)
  require("umlauts.usercmds").setup()

  return M
end

return M
