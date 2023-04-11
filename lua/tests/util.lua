local M = {}

M.find_buf_keymap = function(mode, lhs, buffer)
  local keymaps = vim.api.nvim_buf_get_keymap(buffer or 0, mode)
  for _, keymap in ipairs(keymaps) do
    if keymap.lhs == lhs then
      return keymap
    end
  end
end

return M
