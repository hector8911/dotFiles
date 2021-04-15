local function is_empty(item)
    if not item then return true end
    local item_type = type(item)
    if item_type == "string" then
        return item == ""
    elseif item_type == "table" then
        return vim.tbl_isempty(item)
    end
end

local utils = require("utils")
local H = require("utils.highlights")
local autocommands = require("utils.autocommands")

local P = require("utils.colors").palette
local M = {}

M.git_updates = utils.git_updates
M.git_toggle_updates = utils.git_update_toggle
M.git_updates_refresh = utils.git_updates_refresh

function M.colors()
    H.all {
        {"StIndicator", {guibg = P.bg, guifg = P.blue}},
        {"StTitle", {guibg = P.bg, guifg = P.yellow}},
        {"StInactiveSep", {guibg = P.bg, guifg = P.grey}},

        {"StatusLine", {guibg = P.bg, guifg = P.bg}},
        {"StatusLineNC", {guibg = P.bg, guifg = P.white}},
        {"StFilenameInactive", { guibg = P.bg, guifg = P.fg}},

        {"StDirectory", {guibg = P.bg, guifg = P.grey }},
        {"StParentDirectory",{guibg = P.bg, guifg = P.green}},
        {"StFilename", {guibg = P.bg, guifg = P.white}},

        --Git signs
        {"StInfo", {guibg = P.bg, guifg = P.blue}},
        {"StGreen", {guibg = P.bg, guifg = P.green}},
        {"StWarning", {guibg = P.bg, guifg = P.yellow }},
        {"StError", {guibg = P.bg, guifg = P.red}},

        --Modes
        {"StModeNormal", {guibg = P.bg, guifg = P.fg}},
        {"StModeInsert", {guibg = P.bg, guifg = P.blue}},
        {"StModeVisual", {guibg = P.bg, guifg = P.magenta}},
        {"StModeReplace", {guibg = P.bg, guifg = P.red}},
        {"StModeCommand", {guibg = P.bg, guifg = P.orange}}
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
    ----------------------------------------------------------------------------//
    -- Modifiers
    ----------------------------------------------------------------------------//
    local plain = utils.is_plain(ctx)
    local inactive = vim.api.nvim_get_current_win() ~= curwin
    local focused = vim.g.vim_in_focus or true
    local minimal = plain or inactive or not focused

    ----------------------------------------------------------------------------//
    -- Setup
    ----------------------------------------------------------------------------//
    local statusline = {}
    append(statusline, utils.item_if("▌", not minimal, "StIndicator", {before = "", after = ""}), 0)

    append(statusline, utils.spacer(1))

    ----------------------------------------------------------------------------//
    -- Filename
    ----------------------------------------------------------------------------//
    -- highlight the filename components separately
    local filename_hl = minimal and "StFilenameInactive" or "StFilename"
    local directory_hl = minimal and "StFilenameInactive" or "StDirectory"
    local parent_hl = minimal and directory_hl or "StParentDirectory"

    if H.has_win_highlight(curwin, "Normal", "StatusLine") then
        directory_hl = H.adopt_winhighlight(curwin, "StatusLine","StCustomDirectory", "StTitle")
        filename_hl = H.adopt_winhighlight(curwin, "StatusLine","StCustomFilename", "StTitle")
        parent_hl = H.adopt_winhighlight(curwin, "StatusLine","StCustomParentDir", "StTitle")
    end
    local opt = {icon_bg = "StTitle", default = "StTitle" }

    local ft_icon, icon_highlight = utils.filetype(ctx, opt)

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
        append(statusline, utils.item(status.changed,  "StWarning", { prefix = "" }), 3)
        append(statusline, utils.item(status.removed, "StError", { prefix = "" }), 3)
        append(statusline, utils.item(status.added, "StGreen", { prefix = "" }), 3)
    end

    --number/total
    append(statusline, utils.line_info({
        prefix = "",
        sep = ":",
        prefix_color = "StInactiveSep",
        current_hl = "StTitle",
        total_hl = "StInactiveSep",
        sep_hl = "StInactiveSep"
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
        {
            events = {"VimEnter"},
            targets = {"*"},
            command = "lua require'plugins.statusline'.git_updates()"
        },
        {
            events = {"DirChanged"},
            targets = {"*"},
            command = "lua require'plugins.statusline'.git_toggle_updates()"
        },
        -- NOTE: user autocommands can't be joined into one autocommand
        {
            events = {"User AsyncGitJobComplete"},
            command = "lua require'plugins.statusline'.git_updates_refresh()"
        },
        {
            events = {"User NeogitStatusRefresh"},
            command = "lua require'plugins.statusline'.git_updates_refresh()"
        },
        {
            events = {"User FugitiveChanged"},
            command = "lua require'plugins.statusline'.git_updates_refresh()"
        },
        {events = {"User FugitiveChanged"}, command = "redrawstatus!"}
    })
end

setup_autocommands()
vim.g.qf_disable_statusline = 1
vim.o.statusline = "%!v:lua.statusline()"

return M
