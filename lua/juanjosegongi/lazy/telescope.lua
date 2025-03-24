return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension('noice')

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = "Telescope" })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Telescope git files" })
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("rg > ") })
    end, { desc = "Telescope grep" })
  end
}
