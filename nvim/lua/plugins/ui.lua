local safe_ts_lang = require("config.utils").safe_ts_lang

return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
                format = {
                    cmdline = { pattern = "^:", icon = "", lang = safe_ts_lang("vim") },
                    search_down = { kind = "search", pattern = "^/", icon = " ", lang = safe_ts_lang("regex") },
                    search_up = { kind = "search", pattern = "^%?", icon = " ", lang = safe_ts_lang("regex") },
                    filter = { pattern = "^:%s*!", icon = "$", lang = safe_ts_lang("bash") },
                    lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = safe_ts_lang("lua") },
                    help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                },
            },
            messages = {
                enabled = true,
                view = "notify",
                view_error = "notify",
                view_warn = "notify",
                view_history = "messages",
                view_search = "virtualtext",
            },
            popupmenu = {
                enabled = true,
                backend = "nui",
            },
            notify = {
                enabled = true,
                view = "notify",
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                hover = {
                    enabled = true,
                },
                signature = {
                    enabled = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
        },
    },

    {
        "rcarriga/nvim-notify",
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
            background_colour = "#000000",
        },
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
            { "<leader>E", "<cmd>Neotree focus<cr>",  desc = "Focus Explorer" },
        },
        opts = {
            filesystem = {
                follow_current_file = { enabled = true },
                hijack_netrw_behavior = "open_current",
            },
            window = {
                position = "left",
                width = 30,
            },
        },
    },

    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<Tab>",      "<cmd>BufferLineCycleNext<cr>",   desc = "Next Buffer" },
            { "<S-Tab>",    "<cmd>BufferLineCyclePrev<cr>",   desc = "Prev Buffer" },
            { "<leader>bd", "<cmd>bdelete<cr>",               desc = "Delete Buffer" },
            { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
        },
        opts = {
            options = {
                mode = "buffers",
                diagnostics = "nvim_lsp",
                always_show_bufferline = true,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    component_separators = "|",
                    section_separators = "",
                },
            })
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup()
            require("which-key").add({
                { "<leader>c", group = "Code" },
                { "<leader>d", group = "Document" },
                { "<leader>f", group = "Find" },
                { "<leader>w", group = "Workspace" },
                { "<leader>b", group = "Buffer" },
                { "<leader>t", group = "Terminal" },
                { "<leader>x", group = "Diagnostics" },
            })
        end,
    },
}
