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
    pcall(function() vim.keymap.del("i", lhs) end)
  end
end

return M
