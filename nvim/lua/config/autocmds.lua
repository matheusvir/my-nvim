vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    desc = "Restore terminal cursor to ibeam on exit",
    group = vim.api.nvim_create_augroup("RestoreCursorOnExit", { clear = true }),
    pattern = "*",
    command = "silent !printf '\\x1b[5 q'",
})
