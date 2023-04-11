local defaults = require "umlauts.defaults"
local tu = require "tests.util"

describe("umlauts.autocommands", function()

  before_each(function()
    pcall(vim.api.nvim_clear_autocmds, { group = "UmlautMappings" })
    pcall(vim.keymap.del, "i", "Ae")
    pcall(vim.keymap.del, "i", "Oe")
    pcall(vim.keymap.del, "i", "Ue")
    pcall(vim.keymap.del, "i", "ae")
    pcall(vim.keymap.del, "i", "oe")
    pcall(vim.keymap.del, "i", "ue")
  end)

  it("can be required", function()
    require("umlauts.autocommands")
  end)

  it("can be setup", function()
    require("umlauts.autocommands").setup(defaults)
  end)

  it("creates autocommand for all configured patterns", function()
    require("umlauts.autocommands").setup(defaults)

    local actual = vim.api.nvim_get_autocmds {
      group   = "UmlautMappings",
      event   = { "BufEnter" },
      pattern = defaults.pattern,
    }

    assert.are.same(#defaults.pattern, #actual) -- TODO: improve this assertion
  end)

  it("creates autocommand that disables mapping if spelllang is not set to german", function()
    -- TODO: This test is no testing anything yet. The autocommand didn't run.
    require("umlauts.autocommands").setup { enable = true, pattern = "*" }

    vim.o.spelllang = "en_us"

    assert.is_nil(tu.find_keymap("i", "Ae"))
    assert.is_nil(tu.find_keymap("i", "Oe"))
    assert.is_nil(tu.find_keymap("i", "Ue"))
    assert.is_nil(tu.find_keymap("i", "ae"))
    assert.is_nil(tu.find_keymap("i", "oe"))
    assert.is_nil(tu.find_keymap("i", "ue"))
    assert.is_nil(tu.find_keymap("i", "sz"))
  end)

  it("can be disabled explicitly", function()
    require("umlauts.autocommands").setup { enabled = false }

    local actual = vim.api.nvim_get_autocmds { group = "UmlautMappings" }

    assert.are.same({}, actual)
  end)

  it("is disabled implictly when pattern is nil", function()
    require("umlauts.autocommands").setup { enabled = true }

    local actual = vim.api.nvim_get_autocmds { group = "UmlautMappings" }

    assert.are.same({}, actual)
  end)

  it("is disabled implictly when pattern is empty", function()
    require("umlauts.autocommands").setup { enabled = true, pattern = "" }

    local actual = vim.api.nvim_get_autocmds { group = "UmlautMappings" }

    assert.are.same({}, actual)
  end)
end)
