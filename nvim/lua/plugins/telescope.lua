return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
        { "<leader>fG", "<cmd>Telescope live_grep_args<cr>", desc = "Live Grep Args" },
        { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help Tags" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>",   desc = "Recent Files" },
        { "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer Search" },
        { "<leader>fR", "<cmd>Telescope resume<cr>", desc = "Resume Telescope" },
        { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>fgf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
        { "<leader>fL", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP Document Symbols" },
        { "<leader>fW", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "LSP Workspace Symbols" },
    },
    config = function()
        require("telescope").setup({
            defaults = {
                prompt_prefix = "  ",
                selection_caret = " ",
                path_display = { "smart" },
                sorting_strategy = "ascending",
                layout_strategy = "flex",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        mirror = false,
                    },
                    vertical = {
                        prompt_position = "top",
                        preview_height = 0.55,
                    },
                    flex = {
                        flip_columns = 120,
                    },
                },
                file_ignore_patterns = {
                    ".git/",
                    "node_modules/",
                    "dist/",
                    "build/",
                    "target/",
                    ".venv/",
                },
                mappings = {
                    i = {
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
                live_grep_args = {
                    auto_quoting = true,
                },
            },
        })
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")
        pcall(require("telescope").load_extension, "live_grep_args")
    end,
}
