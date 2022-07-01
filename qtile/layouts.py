from libqtile import layout
from colors import colors, current_window_active_color_line, other_window_active_color_line

layout_theme = {
    "border_width": 2,
    "margin": 10,
    "border_focus": "E1ACFF",
    "border_normal": "1D2330",
    }

layouts = [
    layout.MonadWide(**layout_theme),
    #layout.Bsp(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Slice(fallback=layout.MonadTall(), match=Match(wm_class=['Vivaldi-stable']),**layout_theme),
    #layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
    layout.RatioTile(**layout_theme),
    layout.TreeTab(
         font = "JetBrains Mono Bold",
         fontsize = 10,
         sections = ["Important", "Relevant", "Later"],
         section_fontsize = 8,
         border_width = 2,
         bg_color = colors[1],
         urgent_bg = other_window_active_color_line,
         #active_bg = "c678dd",
         active_bg = current_window_active_color_line,
         active_fg = colors[10],
         # inactive_bg = "a9a1e1",
         # inactive_fg = "1c1f24",
         inactive_bg = colors[2],
         inactive_fg = colors[0],
         padding_left = -1,
         padding_x = -2,
         padding_y = 5,
         section_top = 10,
         section_bottom = 20,
         level_shift = 8,
         vspace = 3,
         panel_width = 200
         ),
    layout.Floating(**layout_theme)
]
