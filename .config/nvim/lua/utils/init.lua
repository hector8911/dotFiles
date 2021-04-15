local H = require("utils.highlights")
local icons_loaded, devicons

local fn = vim.fn
local strwidth = fn.strwidth
local fnamemodify = fn.fnamemodify
local contains = vim.tbl_contains

local M = {}

function M.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local plain_filetypes = {
    "help", "NvimTree", "neoterm", "fugitive", "startify", "markdown", "Git log",
    "NeogitStatus"
}

local function get_toggleterm_name(_, bufnum)
    return "Terminal " .. fn.getbufvar(bufnum, "toggle_number")
end

local plain_buftypes = {"terminal", "nofile", "nowrite", "acwrite"}

local exceptions = {
    filetypes = {
        fugitive = "",
        fugitiveblame = "",
        gitcommit = "",
        gitlog = "",
        NeogitStatus = "",
        startify = "ﳐ",
        help = "",
        NvimTree = "פּ",
        toggleterm = ""
    },
    names = {
        fugitive = "Fugitive",
        fugitiveblame = "Git blame",
        gitcommit = "Git commit",
        gitlog = "Git log",
        NeogitStatus = "Git Status",
        startify = "Startify",
        help = "Help",
        NvimTree = "Explorer",
        toggleterm = get_toggleterm_name
    }
}

local function sum_lengths(tbl)
    local length = 0
    for _, c in ipairs(tbl) do
        if c.length then length = c.length + length end
    end
    return length
end

--Priority
local function is_lowest(item, lowest)
    if not lowest or not lowest.length then return true end
    if not item.priority or not item.length then return false end
    if item.priority == lowest.priority then
        return item.length > lowest.length
    end

    return item.priority > lowest.priority
end

--- Remove items from lower priority
function M.prioritize(statusline, space, length)
    length = length or sum_lengths(statusline)
    if length <= space then return statusline end
    local lowest
    local index_to_remove
    for idx, c in ipairs(statusline) do
        if is_lowest(c, lowest) then
            lowest = c
            index_to_remove = idx
        end
    end
    table.remove(statusline, index_to_remove)
    return M.prioritize(statusline, space, length - lowest.length)
end

function M.is_plain(ctx)
    return contains(plain_filetypes, ctx.filetype) or contains(plain_buftypes, ctx.buftype) or ctx.preview
end

function M.readonly(ctx, icon)
    icon = icon or ""
    if ctx.readonly then
        return " " .. icon
    else
        return ""
    end
end

local function buf_expand(bufnum, mod) return fn.expand("#" .. bufnum .. mod) end


function M.filename(ctx, modifier)
    modifier = modifier or ":t"

    local fname = buf_expand(ctx.bufnum, modifier)

    local name = exceptions.names[ctx.filetype]

    if type(name) == "function" then return "", "", name(fname, ctx.bufnum) end
    if name then return "", "", name end

    --if not fname then return "", "", "No Name" end

    local path = (ctx.buftype == "" and not ctx.preview) and buf_expand(ctx.bufnum, ":~:.:h") or nil
    local is_root = path and #path == 1 -- "~" or "."
    local dir = path and not is_root and
    fn.pathshorten(fnamemodify(path, ":h:h")) .. "/" or ""
    local parent = path and (is_root and path or fnamemodify(path, ":t")) or "" parent = parent ~= "" and parent .. "/" or ""

    return dir, parent, fname
end

local function set_ft_icon_highlight(hl, bg_hl)
    if not hl then
      return ""
    end
    local name = hl .. "Statusline"
    -- TODO: find a mechanism to cache this so it isn't repeated constantly
    local fg_color = H.hl_value(hl, "fg")
    local bg_color = H.hl_value(bg_hl, "bg")
    if bg_color and fg_color then
      local cmd = {"highlight ", name, " guibg=", bg_color, " guifg=", fg_color}
      local str = table.concat(cmd)
      require("utils.autocommands").create({[name] = {{"ColorScheme", "*", str}}})
      vim.cmd(string.format("silent execute '%s'", str))
    end
    return name
  end

function M.filetype(ctx, opts)
    local ft_exception = exceptions.filetypes[ctx.filetype]

    if ft_exception then return ft_exception, opts.default end

    local icon, hl
    local extension = fnamemodify(ctx.bufname, ":e")
    if not icons_loaded then
        icons_loaded, devicons = pcall(require, "nvim-web-devicons")
    end
    if devicons then
        icon, hl = devicons.get_icon(ctx.bufname, extension, {default = true})
        hl = set_ft_icon_highlight(hl, opts.icon_bg)
    end
    return icon, hl
end

--- Decorates the current and total line count
function M.line_info(opts)
    local sep = opts.sep or "/"
    local prefix = opts.prefix or "L"
    local prefix_color = opts.prefix_color
    local current_hl = opts.current_hl
    local total_hl = opts.total_hl
    local sep_hl = opts.total_hl

    local current = fn.line(".")
    local last = fn.line("$")

    local length = strwidth(prefix .. current .. sep .. last)
    return {
        table.concat({
            " ", M.wrap(prefix_color), prefix, " ", M.wrap(current_hl), current,
            M.wrap(sep_hl), sep, M.wrap(total_hl), last, " "
        }), length
    }
end

local function mode_highlight(mode)
    local visual_regex = vim.regex [[\(v\|V\|\)]]
    local command_regex = vim.regex [[\(c\|cv\|ce\|t\)]]
    local replace_regex = vim.regex [[\(Rc\|R\|Rv\|Rx\)]]
    if mode == "i" then
        return "StModeInsert"
    elseif visual_regex:match_str(mode) then
        return "StModeVisual"
    elseif replace_regex:match_str(mode) then
        return "StModeReplace"
    elseif command_regex:match_str(mode) then
        return "StModeCommand"
    else
        return "StModeNormal"
    end
end

function M.mode()
    local current_mode = fn.mode()
    local hl = mode_highlight(current_mode)

    local mode_map = {
        ["n"] = "NORMAL",
        ["no"] = "N·OPERATOR PENDING ",
        ["v"] = "VISUAL",
        ["V"] = "V·LINE",
        [""] = "V·BLOCK",
        ["s"] = "SELECT",
        ["S"] = "S·LINE",
        ["^S"] = "S·BLOCK",
        ["i"] = "INSERT",
        ["R"] = "REPLACE",
        ["Rv"] = "V·REPLACE",
        ["Rx"] = "C·REPLACE",
        ["Rc"] = "C·REPLACE",
        ["c"] = "COMMAND",
        ["cv"] = "VIM EX",
        ["ce"] = "EX",
        ["r"] = "PROMPT",
        ["rm"] = "MORE",
        ["r?"] = "CONFIRM",
        ["!"] = "SHELL",
        ["t"] = "TERMINAL"
    }
    return (mode_map[current_mode] or "UNKNOWN"), hl
end

function M.wrap(hl) return "%#" .. hl .. "#" end

--- Padding
function M.spacer(size, filler)
    filler = filler or " "
    if size and size >= 1 then
        local spacer = string.rep(filler, size)
        return {spacer, #spacer}
    else
        return {"", 0}
    end
end

--Statusline items
function M.item(component, hl, opts)
    if not component or component == "" or component == 0 then
        return M.spacer()
    end
    opts = opts or {}
    local before = opts.before or ""
    local after = opts.after or " "
    local prefix = opts.prefix or ""
    local prefix_size = strwidth(prefix)

    local prefix_color = opts.prefix_color or hl
    prefix = prefix ~= "" and M.wrap(prefix_color) .. prefix .. " " or ""

    --- handle numeric inputs etc.
    if type(component) ~= "string" then component = tostring(component) end

    local parts = {before, prefix, M.wrap(hl), component, after, "%*"}
    return {table.concat(parts), #component + #before + #after + prefix_size}
end

function M.item_if(item, condition, hl, opts)
    if not condition then return M.spacer() end
    return M.item(item, hl, opts)
end

-----------------------------------------------------------------------------//
-- Git/Github helper functions
-----------------------------------------------------------------------------//
local function job(interval, task, on_complete)
    vim.defer_fn(task, 2000)
    local pending_job
    local timer = fn.timer_start(interval, function()
        -- clear previous job
        if pending_job then fn.jobstop(pending_job) end
        pending_job = task()
    end, {["repeat"] = -1})
    if on_complete then on_complete(timer) end
end

local function is_git_repo() return fn.isdirectory(fn.getcwd() .. "/" .. ".git") end

local function git_read(result)
    return function(_, data, _)
        for _, v in ipairs(data) do
            if v and v ~= "" then table.insert(result, v) end
        end
    end
end

local function git_update_status(result)
    return function(_, code, _)
        if code == 0 and result and #result > 0 then
            local parts = vim.split(result[1], "\t")
            if parts and #parts > 1 then
                local formatted = {behind = parts[1], ahead = parts[2]}
                vim.g.git_statusline_updates = formatted
            end
        end
    end
end

local function git_update_job()
    local cmd = "git rev-list --count --left-right @{upstream}...HEAD"
    local result = {}
    return fn.jobstart(cmd, {
        on_stdout = git_read(result),
        on_exit = git_update_status(result)
    })
end

function M.git_updates_refresh() git_update_job() end

function M.git_update_toggle()
    local on = is_git_repo()
    if on then M.git_updates() end
    local status = on and 0 or 1
    fn.timer_pause(vim.g.git_statusline_updates_timer, status)
end

function M.git_updates()
    job(30000, git_update_job,
        function(timer) vim.g.git_statusline_updates_timer = timer end)
end

--check whether the plugin is installed to use local settings
function M.load_plugin(plugin, config)
    if config == nil then
        return require(plugin).setup()
    end
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/'..plugin

    if fn.empty(fn.glob(install_path)) == 0 then
        return require("plugins."..config)
    end
end

return M
