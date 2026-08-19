return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                                       desc = "Diagnostics (Trouble)" },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",                          desc = "Buffer Diagnostics (Trouble)" },
        { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                                           desc = "Location List (Trouble)" },
        { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                                            desc = "Quickfix List (Trouble)" },
        { "[q",         function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Previous Trouble" },
        { "]q",         function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Next Trouble" },
    },
    opts = {
        modes = {
            diagnostics = {
                auto_open = false,
                auto_close = false,
            },
        },
    },
}
