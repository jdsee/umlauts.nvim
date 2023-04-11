local M = {}

local function is_spelllang_set(term)
  for _, lang in ipairs(vim.opt_local.spelllang:get()) do
    if (string.match(lang, "^" .. term)) then
      return true
    end
  end
  return false
end

M.setup = function(opts)
  if not opts.enabled
      or opts.pattern == nil
      or #opts.pattern == 0 then
    return
  end

  local umlauts = require "umlauts"

  local umlaut_mappings_augroup_id = vim.api.nvim_create_augroup("UmlautMappings", { clear = true })

  -- Set insert mappings for German umlauts in text files
  vim.api.nvim_create_autocmd(
    { "BufEnter" },
    {
      group = umlaut_mappings_augroup_id,
      pattern = opts.pattern,
      callback = function()
        if (is_spelllang_set("de")) then
          umlauts.enable_umlaut_mappings()
        end
      end,
    })

  -- Activate/deactivate umlaut mappings when spelllang switched to/from german
  vim.api.nvim_create_autocmd(
    { "OptionSet" },
    {
      group = umlaut_mappings_augroup_id,
      pattern = { "spelllang" },
      callback = function()
        if (is_spelllang_set("de")) then
          vim.api.nvim_exec_autocmds(
            { "BufEnter" },
            { group = umlaut_mappings_augroup_id })
        else
          umlauts.disable_umlaut_mappings()
        end
      end,
    })
end

return M
