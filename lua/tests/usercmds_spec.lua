
describe("umlauts.nvim", function()
  it("can be required", function()
    require("umlauts.usercmds")
  end)

  it("can be setup", function()
    require("umlauts.usercmds").setup()
  end)

  it("sets user commands for enabling umlaut mappings", function()
    require("umlauts.usercmds").setup()

    assert.is.True(vim.fn.exists(':UmlautsEnable') > 0)
  end)

  it("sets user commands for disable umlaut mappings", function()
    require("umlauts.usercmds").setup()

    assert.is.True(vim.fn.exists(':UmlautsDisable') > 0)
  end)

  it("sets user commands for toggling umlaut mappings", function()
    require("umlauts.usercmds").setup()

    assert.is.True(vim.fn.exists(':UmlautsToggle') > 0)
  end)

end)
