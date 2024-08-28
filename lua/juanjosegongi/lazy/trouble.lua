return {
    "folke/trouble.nvim",
    keys = {
        {
            "<leader>tt",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
    },
    config = function(_, opts)
        require("trouble").setup(opts)

        vim.keymap.set("n", "]t", function()
            require("trouble").next({skip_groups = true, jump = true});
        end)

        vim.keymap.set("n", "[t", function()
            require("trouble").prev({skip_groups = true, jump = true});
        end)

    end
}
