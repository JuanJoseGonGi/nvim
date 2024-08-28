require("juanjosegongi.vim")
require("juanjosegongi.remap")
require("juanjosegongi.lazy_init")

local JuanJoseGonGiGroup = vim.api.nvim_create_augroup('JuanJoseGonGi', {})
local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
    group = JuanJoseGonGiGroup,
    callback = function(e)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { buffer = e.buf, desc = "Go to definition" })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { buffer = e.buf, desc = "Hover" })
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, { buffer = e.buf, desc = "Worskpace symbol" })
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, { buffer = e.buf, desc = "Open float" })
        -- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, { buffer = e.buf, desc = "Code action" })
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, { buffer = e.buf, desc = "References" })
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, { buffer = e.buf, desc = "Rename" })
        vim.keymap.set("n", "<leader>vft", function () vim.lsp.buf.format() end, { buffer = e.buf, desc = "Format" })
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, { buffer = e.buf, desc = "Signature help" })
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, { buffer = e.buf, desc = "Go to next diagnostic" })
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, { buffer = e.buf, desc = "Go to prev diagnostic" })
end
})

