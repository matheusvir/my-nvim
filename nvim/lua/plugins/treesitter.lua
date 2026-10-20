return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ok, ts = pcall(require, "nvim-treesitter")
        if not ok then
            return
        end

        ts.setup({})

        ts.install({
            "lua",
            "python",
            "c",
            "cpp",
            "java",
            "vim",
            "vimdoc",
            "go",
            "javascript",
            "typescript",
            "tsx",
            "sql",
            "bash",
            "markdown",
            "markdown_inline",
            "json",
            "yaml",
            "toml",
            "html",
            "css",
            "diff",
            "gitcommit",
            "query",
            "regex",
            "rust",
        })

        vim.api.nvim_create_autocmd("FileType", {
            desc = "Enable treesitter highlighting and indent",
            group = vim.api.nvim_create_augroup("treesitter-enable", { clear = true }),
            callback = function(args)
                local ok_parser, parser = pcall(vim.treesitter.get_parser, args.buf)
                if not ok_parser or parser == nil then
                    return
                end
                vim.treesitter.start(args.buf)
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
