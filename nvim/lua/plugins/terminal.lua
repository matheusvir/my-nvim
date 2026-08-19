return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<C-\\>",     "<cmd>ToggleTerm<cr>",                      desc = "Toggle Terminal",    mode = { "n", "t" } },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",      desc = "Float Terminal" },
        { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
        { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Vertical Terminal" },
    },
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
            winblend = 0,
        },
    },
}
