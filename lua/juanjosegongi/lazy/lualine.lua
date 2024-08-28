return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        extensions = { "fugitive", "lazy", "man", "mason", "oil", "trouble" },
        globalstatus = true
    },
}
