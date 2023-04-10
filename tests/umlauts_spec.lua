local function find_key_map(mode, lhs)
  local keymaps = vim.api.nvim_get_keymap(mode)
  for _, keymap in ipairs(keymaps) do
    if keymap.lhs == lhs then
      return keymap
    end
  end
end

describe("umlauts", function()
  before_each(function()
    pcall(vim.keymap.del, "i", "Ae")
    pcall(vim.keymap.del, "i", "Oe")
    pcall(vim.keymap.del, "i", "Ue")
    pcall(vim.keymap.del, "i", "ae")
    pcall(vim.keymap.del, "i", "oe")
    pcall(vim.keymap.del, "i", "ue")
  end)

  it("can be required", function()
    require("umlauts")
  end)

  it("maps insert mappings when enabled", function()
    local umlauts = require("umlauts")

    umlauts.enable_umlaut_mappings()

    assert.are.same("Ä", find_key_map("i", "Ae").rhs)
    assert.are.same("Ö", find_key_map("i", "Oe").rhs)
    assert.are.same("Ü", find_key_map("i", "Ue").rhs)
    assert.are.same("ä", find_key_map("i", "ae").rhs)
    assert.are.same("ö", find_key_map("i", "oe").rhs)
    assert.are.same("ü", find_key_map("i", "ue").rhs)
  end)

  it("removes insert mappings when disabled", function()
    local umlauts = require("umlauts")
    umlauts.enable_umlaut_mappings()

    umlauts.disable_umlaut_mappings()

    assert.is_nil(find_key_map("i", "Ae"))
    assert.is_nil(find_key_map("i", "Oe"))
    assert.is_nil(find_key_map("i", "Ue"))
    assert.is_nil(find_key_map("i", "ae"))
    assert.is_nil(find_key_map("i", "oe"))
    assert.is_nil(find_key_map("i", "ue"))
  end)

  it("can enable multiple times without crashing", function()
    local umlauts = require("umlauts")
    umlauts.enable_umlaut_mappings()
    umlauts.enable_umlaut_mappings()
  end)

  it("can disable multiple times without crashing", function()
    local umlauts = require("umlauts")
    umlauts.disable_umlaut_mappings()
    umlauts.disable_umlaut_mappings()
  end)
end)
