return { 
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    { "zidhuss/neotest-minitest", lazy = false }
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-minitest")
      },
    })

    require("neotest-minitest")({
      test_cmd = function()
        return vim.tbl_flatten({
          "bundle",
          "exec",
          "rails",
          "test",
        })
      end
    })
  end
}
