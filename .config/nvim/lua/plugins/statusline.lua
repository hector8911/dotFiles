
local utils = require("utils")
local H = require("utils.highlights")
local autocommands = require("utils.autocommands")
local M = {}

local function is_empty(item)
    if not item then return true end
    local item_type = type(item)
    if item_type == "string" then
        return item == ""
    elseif item_type == "table" then
        return vim.tbl_isempty(item)
    end
end

function M.colors()
    H.all {
        {"StIndicator", {guibg = _G.P.bg, guifg = _G.P.blue}},
        {"StTitle", {guibg = _G.P.bg, guifg = _G.P.yellow}},
        {"StInactiveText", {guibg = _G.P.bg, guifg = _G.P.fg}},
        {"StText", {guibg = _G.P.bg, guifg = _G.P.light_yellow}},

        {"StatusLine", {guibg = _G.P.bg, guifg = _G.P.white}},
        {"StatusLineNC", {guibg = _G.P.bg, guifg = _G.P.white}},
        {"StFilenameInactive", { guibg = _G.P.bg, guifg = _G.P.fg}},

        {"StDirectory", {guibg = _G.P.bg, guifg = _G.P.grey }},
        {"StParentDirectory",{guibg = _G.P.bg, guifg = _G.P.green}},
        {"StFilename", {guibg = _G.P.bg, guifg = _G.P.white}},

        --Git icons
        {"StInfo", {guibg = _G.P.bg, guifg = _G.P.blue}},
        {"StGreen", {guibg = _G.P.bg, guifg = _G.P.green}},
        {"StWarning", {guibg = _G.P.bg, guifg = _G.P.yellow }},
        {"StError", {guibg = _G.P.bg, guifg = _G.P.red}},

        --Modes
        {"StModeNormal", {guibg = _G.P.bg, guifg = _G.P.fg}},
        {"StModeInsert", {guibg = _G.P.bg, guifg = _G.P.blue}},
        {"StModeVisual", {guibg = _G.P.bg, guifg = _G.P.magenta}},
        {"StModeReplace", {guibg = _G.P.bg, guifg = _G.P.red}},
        {"StModeCommand", {guibg = _G.P.bg, guifg = _G.P.light_yellow}}
    }
end

local function append(tbl, next, priority)
    priority = priority or 0
    local component, length = unpack(next)
    if component and component ~= "" and next and tbl then
        table.insert(tbl, {
            component = component,
            priority = priority,
            length = length
        })
    end
end

local function display(statusline, available_space)
    local str = ""
    local items = utils.prioritize(statusline, available_space)
    for _, item in ipairs(items) do
        if type(item.component) == "string" then
            str = str .. item.component
        end
    end
    return str
end

function _G.statusline()
    local curwin = vim.g.statusline_winid or 0
    local curbuf = vim.api.nvim_win_get_buf(curwin)

    -- TODO reduce the available space whenever we add
    -- a component so we can use it to determine what to add
    local available_space = vim.fn.winwidth(curwin)
    local ctx = {
        bufnum = curbuf,
        winid = curwin,
        bufname = vim.fn.bufname(curbuf),
        preview = vim.wo[curwin].previewwindow,
        readonly = vim.bo[curbuf].readonly,
        filetype = vim.bo[curbuf].ft,
        buftype = vim.bo[curbuf].bt,
        modified = vim.bo[curbuf].modified,
        fileformat = vim.bo[curbuf].fileformat,
        shiftwidth = vim.bo[curbuf].shiftwidth,
        expandtab = vim.bo[curbuf].expandtab
    }

    -- Modifiers

    local plain = utils.is_plain(ctx)
    local inactive = vim.api.nvim_get_current_win() ~= curwin
    local focused = vim.g.vim_in_focus or true
    local minimal = plain or inactive or not focused

    -- Setup

    local statusline = {}
    append(statusline, utils.item_if("▌", not minimal, "StIndicator", {before = "", after = ""}), 0)

    append(statusline, utils.spacer(1))

    -- Filename

    -- highlight the filename components separately
    local filename_hl = minimal and "StFilenameInactive" or "StFilename"
    local directory_hl = minimal and "StFilenameInactive" or "StDirectory"
    local parent_hl = minimal and directory_hl or "StParentDirectory"

   if H.has_win_highlight(curwin, "Normal", "StatusLine") then
        directory_hl = "StCustomDirectory"..curwin
        filename_hl = "StCustomFilename"..curwin
        parent_hl = "StCustomParentDir"..curwin
    end

    local ft_icon, icon_highlight = utils.filetype(ctx, {icon_bg = "StTitle", default = "StTitle" })

    local file_opts = {before = "", after = ""}
    local parent_opts = {before = "", after = ""}
    local dir_opts = {before = "", after = ""}

    local directory, parent, filename = utils.filename(ctx)

    -- Depending on which filename segments are empty we select a section to add the file icon to
    local dir_empty, parent_empty = is_empty(directory), is_empty(parent)
    local to_update = dir_empty and parent_empty and file_opts or dir_empty and parent_opts or dir_opts

    to_update.prefix = ft_icon
    to_update.prefix_color = icon_highlight

    local dir_item = utils.item(directory, directory_hl, dir_opts)
    local parent_item = utils.item(parent, parent_hl, parent_opts)
    local file_item = utils.item(filename, filename_hl, file_opts)

    local readonly_item = utils.item(utils.readonly(ctx), "StError")

    -- show a minimal statusline
    if minimal then
        append(statusline, dir_item, 3)
        append(statusline, parent_item, 2)
        append(statusline, file_item, 0)
        append(statusline, readonly_item, 2)

        return display(statusline, available_space)
    end

    append(statusline, utils.item(utils.mode()), 0)

    append(statusline, dir_item, 3)
    append(statusline, parent_item, 2)
    append(statusline, file_item, 0)
    append(statusline, readonly_item, 2)
    -- Start of the right side layout
    append(statusline, {"%="})

    -- Git Status
    local status = vim.b.gitsigns_status_dict
    if status then
        append(statusline, utils.item(status.head, "StInfo", { prefix = "" }), 1)
        append(statusline, utils.item(status.added, "StGreen", { prefix = "" }), 3)
        append(statusline, utils.item(status.changed,  "StWarning", { prefix = "" }), 3)
        append(statusline, utils.item(status.removed, "StError", { prefix = "" }), 3)
    end

    --number/total
    append(statusline, utils.line_info({
        prefix = "",
        sep = ":",
        prefix_color = "StInactiveText",
        current_hl = "StText",
        total_hl = "StInactiveText",
        sep_hl = "StInactiveText"
    }), 7)
    append(statusline, {"%<"})

    -- removes 5 columns to add some padding
    return display(statusline, available_space - 5)
end

local function setup_autocommands()
    autocommands.augroup("CustomStatusline", {
        {
            events = {"FocusGained"},
            targets = {"*"},
            command = "let g:vim_in_focus = v:true"
        },
        {
            events = {"FocusLost"},
            targets = {"*"},
            command = "let g:vim_in_focus = v:false"
        },
        {
            events = {"VimEnter", "ColorScheme"},
            targets = {"*"},
            command = "lua require'plugins.statusline'.colors()"
        },
        { events = {"User FugitiveChanged"}, command = "redrawstatus!"}
    })
end

setup_autocommands()
vim.g.qf_disable_statusline = 1
vim.o.statusline = "%!v:lua.statusline()"

return M
