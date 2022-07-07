# -*- coding: utf-8 -*-
import os
import socket
import subprocess
from libqtile.config import Click, Drag, Key, Match, Screen
from libqtile import layout, bar, hook
from libqtile.lazy import lazy
from libqtile.log_utils import logger

from groups import groups
from keys import keys
from layouts import layouts
from colors import colors, other_window_active_color_line, current_window_active_color_line
from widgets import init_widgets_list, widget_defaults, extension_defaults

mod = 'mod4'              # Sets mod key to SUPER/WINDOWS
myTerm = 'alacritty'      # My terminal of choice
myBrowser = 'vivaldi' # My browser of choice


# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
def simple_key_binder(mod, keynames=None):
    """Bind keys to mod+group position or to the keys specified as second argument"""

    def _graceful_fail_call(func, param):
        try:
            func(param)
        except KeyError:
            logger.warning('Name Bloody Group', groups[0].name)
            logger.warning('Key not found in dgroup keys: "%s"', str(param))

    def func(dgroup):
        # unbind all
        for key in dgroup.keys[:]:
            _graceful_fail_call(dgroup.qtile.ungrab_key, key)
            _graceful_fail_call(dgroup.keys.remove, key)

        if keynames:
            keys = keynames
        else:
            # keys 1 to 9 and 0
            keys = list(map(str, list(range(1, 10)) + [0]))

        # bind all keys
        for keyname, group in zip(keys, dgroup.qtile.groups):
            name = group.name
            key = Key([mod], keyname, lazy.group[name].toscreen())
            key_s = Key([mod, 'shift'], keyname, lazy.window.togroup(name))
            key_c = Key([mod, 'control'], keyname, lazy.group.switch_groups(name))
            dgroup.keys.append(key)
            dgroup.keys.append(key_s)
            dgroup.keys.append(key_c)
            dgroup.qtile.grab_key(key)
            dgroup.qtile.grab_key(key_s)
            dgroup.qtile.grab_key(key_c)

    return func

dgroups_key_binder = simple_key_binder(mod)

prompt = f'%s@%s: ' % (os.environ['USER'], socket.gethostname())

def init_widgets_secondary_screen():
    # Slicing removes unwanted widgets (systray)
    widgets = init_widgets_list()
    del widgets[9:10]
    return widgets

def init_widgets_main_screen():
    # will display all widgets in widgets_list
    return init_widgets_list()

def get_random_wallpaper():
    import random

    root_src = f'/usr/share/backgrounds/budgie/%s'
    wallpapers_files = [
        'default.jpg', 
        'spray_flower_by_bakpaul.jpg', 
        'stones_in_lake_and_blue_mountains_by_sigisagi.jpg', 
        'ubuntu_budgie_wallpaper1.jpg', 
        'ubuntu_budgie_wallpaper2.jpg', 
        'ubuntu_budgie_wallpaper3.jpg', 
    ]

    return root_src % wallpapers_files[int(random.uniform(0, len(wallpapers_files)))]

###### Hooks #######
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/startup.sh'])

###### Main Functions #######
def init_screens():
    # margin N E S W
    bar_margin = [0, 0, 0, 0]
    return [Screen(wallpaper=get_random_wallpaper(), top=bar.Bar(margin=bar_margin, widgets=init_widgets_secondary_screen(), opacity=0.85, size=20)),
            Screen(wallpaper=get_random_wallpaper(), top=bar.Bar(margin=bar_margin, widgets=init_widgets_main_screen(), opacity=0.85, size=20)),
            Screen(top=bar.Bar(margin=bar_margin, widgets=init_widgets_secondary_screen(), opacity=1.0, size=20))]

if __name__ in ['config', '__main__']:
    screens = init_screens()

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

########## Default config variables ##########
mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], 'Button2', lazy.window.bring_to_front())
]

dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),
    Match(title='Pomotroid'),        # qalculate-gtk
    Match(wm_class='electron'),       # kdenlive
])

focus_on_window_activation = 'smart'
# Allow windows to go fullscren. I changed to False
auto_fullscreen = False
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = 'LG3D'
