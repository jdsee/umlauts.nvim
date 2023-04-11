local tu = require "tests.util"

describe("umlauts.nvim", function()

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

  it("can be setup", function()
    require("umlauts").setup()
  end)

  it("can map insert mappings when enabled", function()
    local umlauts = require("umlauts")

    umlauts.enable_umlaut_mappings()

    assert.are.same("Ä", tu.find_buf_keymap("i", "Ae").rhs)
    assert.are.same("Ö", tu.find_buf_keymap("i", "Oe").rhs)
    assert.are.same("Ü", tu.find_buf_keymap("i", "Ue").rhs)
    assert.are.same("ä", tu.find_buf_keymap("i", "ae").rhs)
    assert.are.same("ö", tu.find_buf_keymap("i", "oe").rhs)
    assert.are.same("ü", tu.find_buf_keymap("i", "ue").rhs)
  end)

  it("removes insert mappings when disabled", function()
    local umlauts = require("umlauts")
    umlauts.enable_umlaut_mappings()

    umlauts.disable_umlaut_mappings()

    assert.is_nil(tu.find_buf_keymap("i", "Ae"))
    assert.is_nil(tu.find_buf_keymap("i", "Oe"))
    assert.is_nil(tu.find_buf_keymap("i", "Ue"))
    assert.is_nil(tu.find_buf_keymap("i", "ae"))
    assert.is_nil(tu.find_buf_keymap("i", "oe"))
    assert.is_nil(tu.find_buf_keymap("i", "ue"))
  end)

  it("can be enabled multiple times without crashing", function()
    local umlauts = require("umlauts")

    umlauts.enable_umlaut_mappings()
    umlauts.enable_umlaut_mappings()
  end)

  it("can be disabled multiple times without crashing", function()
    local umlauts = require("umlauts")

    umlauts.disable_umlaut_mappings()
    umlauts.disable_umlaut_mappings()
  end)

  it("enables umlaut mappings when toggled once", function()
    local umlauts = require("umlauts").setup()

    umlauts.toggle_umlaut_mappings()

    assert.are.same("ä", tu.find_buf_keymap("i", "ae").rhs)
  end)

  it("disables umlaut mappings when toggled twice", function()
    local umlauts = require("umlauts").setup()

    umlauts.toggle_umlaut_mappings()
    umlauts.toggle_umlaut_mappings()

    assert.is_nil(tu.find_buf_keymap("i", "ae"))
  end)

  it("should be disabled by default", function()
    require("umlauts").setup()

    assert.is_nil(tu.find_buf_keymap("i", "ae"))
  end)

end)
