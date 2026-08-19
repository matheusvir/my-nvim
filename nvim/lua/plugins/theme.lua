return {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("cyberdream").setup({
            transparent = true,
            italic_comments = true,
            hide_fillchars = false,
            borderless_telescope = false,
            terminal_colors = true,

            theme = {
                variant = "default",
                saturation = 1,
                highlights = {
                    Normal = { bg = "#000000" },
                    NormalFloat = { bg = "#000000" },
                    NormalNC = { bg = "#000000" },
                    SignColumn = { bg = "#000000" },
                    EndOfBuffer = { bg = "#000000", fg = "#000000" },
                },
            },
        })
        vim.cmd("colorscheme cyberdream")
    end,
}
