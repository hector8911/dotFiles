
require'bufferline'.setup {
    options = {
        show_close_icon = false,
        show_buffer_close_icons = false,
        diagnostics = "nvim_lsp" or false,
        separator_style = "thick",
        diagnostics_indicator = function(count, level, diagnostics_dict)
            local result = {}
            if level == "error" then table.insert(result, "") end
            result = table.concat(result, " ")
            return #result > 0 and " " .. result or ""
        end
    },
    highlights = {
        fill = {guibg = _G.P.bg},
        error_diagnostic_selected = {guifg = _G.P.red},
        error_selected = {guifg = _G.P.red}
    }
}
