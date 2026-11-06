return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local treesitter = require 'nvim-treesitter'
      local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
      treesitter.install(parsers)

      local function attach(buf, language)
        -- Installation is asynchronous; the original buffer may have been closed.
        if not vim.api.nvim_buf_is_valid(buf) then return end
        if not vim.treesitter.language.add(language) then return end

        vim.treesitter.start(buf, language)

        -- Preserve Vim's indentation when no Treesitter indent query exists.
        if vim.treesitter.query.get(language, 'indents') then vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
      end

      local available = treesitter.get_available()
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('kickstart-treesitter', { clear = true }),
        callback = function(event)
          local language = vim.treesitter.language.get_lang(event.match)
          if not language then return end

          local installed = treesitter.get_installed 'parsers'
          if vim.tbl_contains(installed, language) then
            attach(event.buf, language)
            return
          end

          if vim.tbl_contains(available, language) then
            treesitter.install(language):await(function() attach(event.buf, language) end)
            return
          end

          -- A parser may be provided by Neovim or another plugin.
          attach(event.buf, language)
        end,
      })
    end,
  },
}
