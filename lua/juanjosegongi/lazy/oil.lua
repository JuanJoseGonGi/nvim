return {
    'stevearc/oil.nvim',
    opts = {
        watch_for_changes = true,
        keymaps = {
            ["<C-h>"] = false,
            ["<C-l>"] = false,
        }
    },
    dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.icons" },
}
