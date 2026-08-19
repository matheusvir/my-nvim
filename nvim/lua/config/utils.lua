local M = {}

function M.safe_ts_lang(lang)
    local ts = vim.treesitter
    if not ts or not ts.query or not ts.query.get then
        return "text"
    end
    local ok = pcall(ts.query.get, lang, "highlights")
    if ok then
        return lang
    end
    return "text"
end

return M
