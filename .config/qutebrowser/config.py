config.load_autoconfig()

bg = "#181818"
fg = "#d8d8d8"
yellow = "#fff800"
bg_alt = '#34352f'
red = "#ff1e8e"
blue = '#1e8eff'
grey = '#8F908A'

c.colors.completion.category.bg = bg
c.colors.completion.category.fg = blue
c.colors.completion.category.border.bottom = bg
c.colors.completion.category.border.top = bg
c.colors.completion.fg = fg
c.colors.completion.odd.bg = bg
c.colors.completion.even.bg = bg
c.colors.completion.match.fg = red
c.colors.completion.item.selected.match.fg = red
c.colors.completion.item.selected.fg = fg
c.colors.completion.item.selected.bg = bg_alt
c.colors.completion.item.selected.border.bottom = bg
c.colors.completion.item.selected.border.top = bg

c.colors.downloads.bar.bg = bg

c.colors.webpage.preferred_color_scheme = "dark"

c.colors.statusbar.insert.bg = bg 
c.colors.statusbar.insert.fg = fg
c.colors.statusbar.url.success.https.fg = fg

c.colors.tabs.even.bg = bg_alt
c.colors.tabs.odd.bg = bg_alt
c.colors.tabs.even.fg = grey
c.colors.tabs.odd.fg = grey
c.colors.tabs.selected.even.bg = bg
c.colors.tabs.selected.odd.bg = bg
c.colors.tabs.selected.odd.fg = fg
c.colors.tabs.selected.even.fg = fg
c.colors.tabs.pinned.even.bg = bg_alt
c.colors.tabs.pinned.odd.bg = bg_alt
c.colors.tabs.pinned.odd.fg = grey
c.colors.tabs.pinned.even.fg = grey
c.colors.tabs.pinned.selected.even.bg = bg
c.colors.tabs.pinned.selected.odd.bg = bg
c.colors.tabs.pinned.selected.even.fg = fg
c.colors.tabs.pinned.selected.odd.fg = fg

c.confirm_quit = ['downloads']
c.content.javascript.modal_dialog = True

c.downloads.position = "bottom"
c.fonts.default_family = ["Hack Nerd Font Bold"]

c.statusbar.widgets =["url"]

c.tabs.show = "switching"
c.tabs.show_switching_delay = 1500
c.tabs.title.format = "{audio}{current_title}"
c.tabs.title.format_pinned = '{audio}'
c.tabs.indicator.width = 0

config.bind('<Alt-l>', 'tab-next')
config.bind('<Alt-h>', 'tab-prev')

