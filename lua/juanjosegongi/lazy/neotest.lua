return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-golang")({
                        go_test_args = {
                            "-shuffle=on",
                            "-race",
                        }
                    }),
                },
      })
    end,
  },
}
