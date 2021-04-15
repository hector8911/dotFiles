vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
    min_length = 2;
    preselect = "always";
    max_kind_width = 3;
    max_abbr_width = 20;
    max_menu_width= 0;

    source = {
        path = {kind = "[Dir]"},
        buffer = false,
        calc = false,
        nvim_lsp = {kind = "  "},
        nvim_lua = false,
        vsnip = {kind = "  "},
        tags = false,
    };
}
