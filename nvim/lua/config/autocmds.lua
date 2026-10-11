vim.g.autoformat_enabled = false

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
        if vim.g.autoformat_enabled == true then
            pcall(vim.lsp.buf.format, { async = false })
        end
    end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    desc = "Restore terminal cursor to ibeam on exit",
    group = vim.api.nvim_create_augroup("RestoreCursorOnExit", { clear = true }),
    pattern = "*",
    command = "silent !printf '\\x1b[5 q'",
})
