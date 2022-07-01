import os
from libqtile import layout, bar, widget, hook
from colors import colors, other_window_active_color_line, current_window_active_color_line

##### Widget Settings #####
widget_defaults = {
    'font': 'JetBrains Mono Bold',
    'fontsize': 10,
    'padding': 2,
    'background': colors[2]
}

extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.Image(
                  # filename = '~/.config/qtile/icons/python-white.png',
                       filename = '~/.config/qtile/icons/sigma.png',
                       background = colors[0],
                       scale = 'False',
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm)}
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
              widget.GroupBox(
                       font = 'JetBrains Mono Bold',
                       disable_drag = True,
                       fontsize = 9,
                       margin_y = 3,
                       margin_x = 0,
                       padding_y = 5,
                       padding_x = 3,
                       borderwidth = 3,
                       active = colors[2],
                       inactive = colors[7],
                       rounded = False,
                       highlight_color = colors[1],
                       highlight_method = 'line',
                       # this_current_screen_border = colors[6],
                       # this_screen_border = colors[4],
                       # other_current_screen_border = colors[6],
                       # other_screen_border = colors[4],
                       this_current_screen_border = current_window_active_color_line,
                       this_screen_border = other_window_active_color_line,
                       other_current_screen_border = current_window_active_color_line,
                       other_screen_border = other_window_active_color_line,
                       foreground = colors[2],
                       background = colors[0]

                       ),
             widget.TextBox(
                       text = '|',
                       font = 'JetBrains Mono',
                       background = colors[0],
                       foreground = '474747',
                       padding = 2,
                       fontsize = 14
                       ),
              widget.CurrentLayoutIcon(
                       custom_icon_paths = [os.path.expanduser('~/.config/qtile/icons')],
                       foreground = colors[2],
                       background = colors[0],
                       padding = 0,
                       scale = 0.7
                       ),
              widget.CurrentLayout(
                       foreground = colors[2],
                       background = colors[0],
                       padding = 5
                       ),
             widget.TextBox(
                       text = '|',
                       font = 'JetBrains Mono',
                       background = colors[0],
                       foreground = '474747',
                       padding = 2,
                       fontsize = 14
                       ),
              widget.WindowName(
                       foreground = colors[6],
                       background = colors[0],
                       padding = 0
                       ),
              widget.Systray(
                       background = colors[0],
                       padding = 5
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[0],
                       background = colors[0]
                       ),
              widget.TextBox(
                      # text = '',
                       text='◢',
                       font = 'JetBrains Mono',
                       background = colors[0],
                       foreground = colors[3],
                       padding = 0,
                       fontsize = 37
                       ),
             widget.Net(
                       interface = 'wlp0s20f3',
                       format = 'Net: {down} ↓↑ {up}',
                       foreground = colors[1],
                       background = colors[3],
                       padding = 5
                       ),
              widget.TextBox(
                      # text = '',
                       text='◢',
                       font = 'JetBrains Mono',
                       background = colors[3],
                       foreground = colors[4],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.ThermalSensor(
                       foreground = colors[1],
                       background = colors[4],
                       threshold = 90,
                       fmt = 'Temp: {}',
                       padding = 5
                       ),
              widget.TextBox(
                      # text = '',
                       text='◢',
                       font = 'JetBrains Mono',
                       background = colors[4],
                       foreground = colors[5],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.Battery(
                       font = 'JetBrains Mono Bold',
                       foreground = colors[10],
                       background = colors[5],
                       padding = 5,
                       charge_char = '↗',
                       discharge_char = '↓',
                       full_char = '█',
                       empty_char = '_|_',
                       format = '{percent:0.0%} {char}',
                       fmt = 'Battery: {}',
                       show_short_text = False
                      ),
              widget.TextBox(
                      # text = '',
                       text='◢',
                       font = 'JetBrains Mono',
                       background = colors[5],
                       foreground = colors[6],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.Memory(
                       foreground = colors[10],
                       background = colors[6],
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')},
                       fmt = 'Mem: {}',
                       padding = 5
                       ),
              widget.TextBox(
                      # text = '',
                       text='◢',
                       font = 'JetBrains Mono',
                       background = colors[6],
                       foreground = colors[7],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.Volume(
                       foreground = colors[10],
                       background = colors[7],
                       fmt = 'Vol: {}',
                       padding = 5,
                       # the command amixer -q -D pulse gets the Master channel.
                       # Ubuntu use pulseaudio to manager volume
                       volume_app = 'budgie-control-center sound',
                       device = 'pulse',
                       ),
              widget.TextBox(
                       text='◢',
                       # text = '',
                       font = 'JetBrains Mono',
                       background = colors[7],
                       foreground = colors[8],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.Bluetooth(
                       foreground = colors[10],
                       background = colors[8],
                       hci = '/dev_F8_8A_3C_37_07_9C',
                       fmt = 'BT: {}'
                      ),
#               widget.KeyboardLayout(
#                        foreground = colors[1],
#                        background = colors[8],
#                        fmt = 'Keyboard: {}',
#                        padding = 5
#                        ),
              widget.TextBox(
                      # text = '',
                       font = 'JetBrains Mono',
                       text='◢',
                       background = colors[8],
                       foreground = colors[9],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.Clock(
                       foreground = colors[10],
                       background = colors[9],
                       format = '%A, %d %B %Y ~~> %H:%M '
                       )
              ]
    return widgets_list
