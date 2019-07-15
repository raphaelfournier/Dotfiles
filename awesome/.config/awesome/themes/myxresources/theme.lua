-------------------------------
--  MyXresources
--  By RFS -- 05-2019
-------------------------------

local xresources = require("beautiful").xresources
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

-- inherit default theme
local theme = dofile("/usr/share/awesome/themes/default/theme.lua")
-- load vector assets' generators for this theme
local theme_assets = dofile("/usr/share/awesome/themes/xresources/assets.lua")

-- {{{ Main

local theme = {}
local shape = require( "gears.shape" )

theme.wallpaper = "/home/raph/.config/mainscreen.png"
theme.wallpaperlandscape = "/home/raph/.config/landscape.jpg"
theme.wallpaperportrait = "/home/raph/.config/portrait.jpg"
-- }}}

-- {{{ Styles
theme.font      = "Inconsolata Medium 16"

-- {{{ Colors
theme.fg_normal     = xrdb.foreground
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = theme.bg_normal
theme.bg_normal     = xrdb.background
theme.bg_focus      = xrdb.color12
theme.bg_urgent     = xrdb.color9
theme.bg_systray = theme.bg_normal
theme.bg_minimize   = xrdb.color8
theme.fg_minimize   = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap   = 15
theme.border_width  = 5
theme.border_normal = "#000000"
--theme.border_focus  = "#111111" -- vert
theme.border_focus  = "#7f9f7f" -- vert
theme.border_marked = "#91231c"
-- }}}

-- {{{ Titlebars
theme = theme_assets.recolor_titlebar_normal(theme, theme.fg_normal)
theme = theme_assets.recolor_titlebar_focus(theme, theme.fg_focus)
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
theme.tasklist_fg_minimize = "#DCDCCC"
theme.tasklist_bg_minimize = "#4F4F4F"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = 24
theme.menu_width  = 300
-- }}}

-- {{{ Icons

-- {{{ Colors
--theme.tag_icon_term = "/home/raph/Images/Icons/term.png"
--theme.tag_icon_web = "/home/raph/Images/Icons/web.png"
--theme.tag_icon_mail = "/home/raph/Images/Icons/mail.png"
--theme.tag_icon_im = "/home/raph/Images/Icons/im.png"
--theme.tag_icon_media = "/home/raph/Images/Icons/musical-note.png"
--theme.tag_icon_pdf = "/home/raph/Images/Icons/pdf.png"
--theme.tag_icon_graph = "/home/raph/Images/Icons/paint-brush-xxl.png"
--theme.tag_icon_root = "/home/raph/Images/Icons/chess-16-xxl.png"
--theme.tag_icon_term2 = "/home/raph/Images/Icons/hat-xxl.png"
--theme.tag_icon_todo = "/home/raph/Images/Icons/today-xxl.png"

theme.tag_icon_term = "/home/raph/Images/Icons/term.png"
theme.tag_icon_term = "/home/raph/Images/Icons/term.png"
theme.tag_icon_web = "/home/raph/Images/Icons/web.png"
theme.tag_icon_mail = "/home/raph/Images/Icons/mail.png"
theme.tag_icon_im = "/home/raph/Images/Icons/im.png"
theme.tag_icon_media = "/home/raph/Images/Icons/musical-note.png"
theme.tag_icon_pdf = "/home/raph/Images/Icons/pdf.png"
theme.tag_icon_graph = "/home/raph/Images/Icons/paint-brush-xxl.png"
theme.tag_icon_root = "/home/raph/Images/Icons/chess-16-xxl.png"
theme.tag_icon_term2 = "/home/raph/Images/Icons/hat-xxl.png"
theme.tag_icon_todo = "/home/raph/Images/Icons/today-xxl.png"
-- }}}

-- {{{ Taglist
local taglist_square_size = 5
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)
--theme.taglist_squares_sel   = "/usr/share/awesome/themes/zenburn/taglist/squarefz.png"
--theme.taglist_squares_unsel = "/usr/share/awesome/themes/zenburn/taglist/squarez.png"
--theme.taglist_squares_resize = "false"

theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_bg_occupied = theme.bg_focus .. "80"

theme.taglist_bg_focus = theme.border_focus
theme.taglist_bg_urgent = theme.fg_urgent
--
--theme.taglist_squares_resize = "false"
-- }}}

local bg_numberic_value = 0;
for s in theme.bg_normal:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
    bg_numberic_value = bg_numberic_value + tonumber("0x"..s);
end
local is_dark_bg = (bg_numberic_value < 383)

-- {{{ Misc
theme.awesome_icon           = "/usr/share/awesome/themes/zenburn/awesome-icon.png"
theme.coffee                 = "/home/raph/.config/awesome/themes/myzenburn/coffee-zenburn.png"
theme.demomode_icon               = "/home/raph/.config/awesome/themes/myzenburn/demomode.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = "/usr/share/awesome/themes/zenburn/layouts/tile.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/zenburn/layouts/tileleft.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/zenburn/layouts/tilebottom.png"
theme.layout_tiletop    = "/usr/share/awesome/themes/zenburn/layouts/tiletop.png"
theme.layout_fairv      = "/usr/share/awesome/themes/zenburn/layouts/fairv.png"
theme.layout_fairh      = "/usr/share/awesome/themes/zenburn/layouts/fairh.png"
theme.layout_spiral     = "/usr/share/awesome/themes/zenburn/layouts/spiral.png"
theme.layout_dwindle    = "/usr/share/awesome/themes/zenburn/layouts/dwindle.png"
theme.layout_max        = "/usr/share/awesome/themes/zenburn/layouts/max.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/zenburn/layouts/fullscreen.png"
theme.layout_magnifier  = "/usr/share/awesome/themes/zenburn/layouts/magnifier.png"
theme.layout_floating   = "/usr/share/awesome/themes/zenburn/layouts/floating.png"
theme.layout_cornernw   = "/usr/share/awesome/themes/zenburn/layouts/cornernw.png"
theme.layout_cornerne   = "/usr/share/awesome/themes/zenburn/layouts/cornerne.png"
theme.layout_cornersw   = "/usr/share/awesome/themes/zenburn/layouts/cornersw.png"
theme.layout_cornerse   = "/usr/share/awesome/themes/zenburn/layouts/cornerse.png"
theme.layout_treetile   = "/home/raph/.config/awesome/themes/myzenburn/layouts/treetile.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/zenburn/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = "/usr/share/awesome/themes/default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = "/usr/share/awesome/themes/default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

-- {{{ Hotkey popup

theme.hotkeys_font = "Inconsolata Medium 14"
theme.hotkeys_description_font = "Inconsolata Medium 14"
theme.hotkeys_modifiers_fg = "#F0DFAF"

-- }}}

-- Tasklist 
--theme.tasklist_spacing = 14
theme.tasklist_shape = shape.rounded_bar
theme.tasklist_fg_focus = theme.bg_focus
theme.tasklist_bg_focus = theme.fg_focus .. "90"
theme.tasklist_fg_normal = theme.fg_normal
theme.tasklist_bg_normal = theme.bg_focus .. "90"
theme.tasklist_fg_minimize = "#DCDCCC"
theme.tasklist_bg_minimize = "#4F4F4F" .. "90"

--theme.fg_normal  = "#DCDCCC"
-- icons
theme.tasklist_sticky = "-S "
theme.tasklist_ontop = "-T "
theme.tasklist_floating = "-F "
theme.tasklist_maximized = "-M "
theme.tasklist_maximized_horizontal = "-MH "
theme.tasklist_maximized_vertical = "-MV "
--theme.tasklist_above = 
--theme.tasklist_below = 
--

theme.widget_main_color = "#DCDCCC"
theme.widget_red = "#CC9393"
theme.widget_yellow = "#F0DFAF"
theme.widget_green = "#7f9f7f"
theme.widget_black = "#1E2320"
theme.widget_blue = "#8787d7"
theme.widget_transparent = "#00000000"

theme.collision_bg_focus="#7f9f7f" -- 	The background of the focus change arrow
theme.collision_fg_focus="#F0DFAF" -- 	The foregroung filling color of the arrow
--theme.collision_bg_center 	The focussed client circle background
theme.collision_resize_width=30 -- 	The size of the resize handles
theme.wibar_bg = theme.fg_normal .. "05" -- transparent
theme.wibar_fg = theme.bg_normal

theme.arcwidgets_thickness = 2
theme.arcwidgets_font = "Inconsolata Medium "
theme.arcwidgets_fontsize = "10"

theme.prompt_bg = theme.wibar_bg

theme.tooltip_border_width = 2
theme.tooltip_border_color = theme.bg_focus
theme.tooltip_bg = theme.border_focus
theme.tooltip_fg = theme.bg_focus
theme.tooltip_opacity = 0.8
theme.tooltip_shape = shape.rounded_bar

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
