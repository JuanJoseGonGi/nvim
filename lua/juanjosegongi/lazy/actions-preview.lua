return {
    "aznhe21/actions-preview.nvim",
    config = function(_, opts)
        require("actions-preview").setup(opts)
        vim.keymap.set({ "v", "n" }, "<leader>vca", require("actions-preview").code_actions, { desc = "Code actions" })
    end
}
