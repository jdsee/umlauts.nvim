local umlauts = require "umlauts"
local M = {}

M.setup = function()
  vim.api.nvim_create_user_command(
    "UmlautsEnable",
    umlauts.enable_umlaut_mappings,
    { desc = "Enables insert mappings that translate spelled out german umlauts to the actual letters." })

  vim.api.nvim_create_user_command(
    "UmlautsDisable",
    umlauts.disable_umlaut_mappings,
    { desc = "Disables insert mappings that translate spelled out german umlauts to the actual letters." })

  vim.api.nvim_create_user_command(
    "UmlautsToggle",
    umlauts.toggle_umlaut_mappings,
    { desc = "Toggles insert mappings that translate spelled out german umlauts to the actual letters." })
end

return M
