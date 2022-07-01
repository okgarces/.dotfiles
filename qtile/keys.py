from libqtile.config import KeyChord, Key
from libqtile.lazy import lazy

mod = 'mod4'              # Sets mod key to SUPER/WINDOWS
myTerm = 'alacritty'      # My terminal of choice
myBrowser = 'vivaldi' # My browser of choice

keys = [
         ### The essentials
         Key([mod], 'Return',
             lazy.spawn(myTerm+' -e zsh'),
             desc='Launches My Terminal'
             ),
         Key([mod, 'shift'], 'Return',
             lazy.spawn('dmenu_run -p "Run: "'),
             desc='Run Launcher'
             ),
         Key([mod], 'b',
             lazy.spawn(myBrowser),
             desc='Default Web Browser'
             ),
         Key([mod, 'mod1', 'shift'], 'space',
             lazy.spawn('rofi -show run')
             ),
         Key([mod, 'mod1'], 'space',
             lazy.spawn('rofi -show combi')
             ),
         Key([mod, 'mod1'], 'e',
             lazy.spawn('rofi -show filebrowser'),
             desc='Run Launcher'
             ),
         Key([mod], 'Tab',
             lazy.next_layout(),
             desc='Toggle through layouts'
             ),
         Key([mod, 'shift'], 'c',
             lazy.window.kill(),
             desc='Kill active window'
             ),
         Key([mod, 'shift'], 'r',
             lazy.restart(),
             desc='Restart Qtile'
             ),
         Key([mod, 'shift'], 'q',
             lazy.shutdown(),
             desc='Shutdown Qtile'
             ),
         Key(['control', 'shift'], 'e',
             lazy.spawn(myTerm+' -e nvim .'),
             desc='nvim '
             ),
         ### Switch focus to specific monitor (out of three)
         Key([mod], 'w',
             lazy.to_screen(0),
             desc='Keyboard focus to monitor 1'
             ),
         Key([mod], 'e',
             lazy.to_screen(1),
             desc='Keyboard focus to monitor 2'
             ),
         Key([mod], 'r',
             lazy.to_screen(2),
             desc='Keyboard focus to monitor 3'
             ),
         ### Switch focus of monitors
         Key([mod], 'period',
             lazy.next_screen(),
             desc='Move focus to next monitor'
             ),
         Key([mod], 'comma',
             lazy.prev_screen(),
             desc='Move focus to prev monitor'
             ),
         ### Treetab controls
          Key([mod, 'shift'], 'h',
             lazy.layout.move_left(),
             desc='Move up a section in treetab'
             ),
         Key([mod, 'shift'], 'l',
             lazy.layout.move_right(),
             desc='Move down a section in treetab'
             ),
         ### Window controls
         Key([mod], 'j',
             lazy.layout.down(),
             desc='Move focus down in current stack pane'
             ),
         Key([mod], 'k',
             lazy.layout.up(),
             desc='Move focus up in current stack pane'
             ),
         Key([mod, 'shift'], 'j',
             lazy.layout.shuffle_down(),
             lazy.layout.section_down(),
             desc='Move windows down in current stack'
             ),
         Key([mod, 'shift'], 'k',
             lazy.layout.shuffle_up(),
             lazy.layout.section_up(),
             desc='Move windows up in current stack'
             ),
         Key([mod], 'h',
             lazy.layout.shrink(),
             lazy.layout.decrease_nmaster(),
             desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
             ),
         Key([mod], 'l',
             lazy.layout.grow(),
             lazy.layout.increase_nmaster(),
             desc='Expand window (MonadTall), increase number in master pane (Tile)'
             ),
         Key([mod], 'n',
             lazy.layout.reset(),
             desc='normalize window size ratios'
             ),
         Key([mod], 'm',
             lazy.layout.maximize(),
             desc='toggle window between minimum and maximum sizes'
             ),
         Key([mod, 'shift'], 'f',
             lazy.window.toggle_floating(),
             desc='toggle floating'
             ),
         Key([mod], 'f',
             lazy.window.toggle_fullscreen(),
             desc='toggle fullscreen'
             ),

         ### Stack controls
         Key([mod, 'shift'], 'Tab',
             lazy.layout.rotate(),
             lazy.layout.flip(),
             desc='Switch which side main pane occupies (XmonadTall)'
             ),
          Key([mod], 'space',
             lazy.layout.next(),
             desc='Switch window focus to other pane(s) of stack'
             ),
         Key([mod, 'shift'], 'space',
             lazy.layout.toggle_split(),
             desc='Toggle between split and unsplit sides of stack'
             ),

         # Emacs programs launched using the key chord CTRL+e followed by 'key'
         KeyChord(['control'],'e', [
             Key([], 'e',
                 lazy.spawn('emacsclient -c -a \'emacs\''),
                 desc='Launch Emacs'
                 ),
             Key([], 'b',
                 lazy.spawn('emacsclient -c -a \'emacs\' --eval \'(ibuffer)\''),
                 desc='Launch ibuffer inside Emacs'
                 ),
             Key([], 'd',
                 lazy.spawn('emacsclient -c -a \'emacs\' --eval \'(dired nil)\''),
                 desc='Launch dired inside Emacs'
                 )
         ]),
]
