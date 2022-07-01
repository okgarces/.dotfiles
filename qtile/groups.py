from libqtile.config import Group, Match

www = { 'layout': 'treetab', 'matches': [Match(wm_class=['Vivaldi-stable', 'Brave-browser', 'firefox'])]}
management = { 'layout': 'max', 'matches': [Match(wm_class=['clickup'])]}
music = { 'layout': 'monadtall', 'matches': [Match(wm_class=['spotify'])]}
docs = { 'layout': 'monadtall', 'matches': [Match(wm_class=['Logseq', 'org.jabref.gui.JabRefMain'])]}
comm = { 'layout': 'monadtall', 'matches': [Match(wm_class=['Ferdium'])]}

groups = [Group('1::dev', layout='monadtall'),
        Group('2::www', **www),
        Group('3::docs', **docs),
        Group('4::comm', **comm),
        Group('5::music', **music),
        Group('6::management', **management),
        Group('7::sys', layout='monadtall'),
        Group('8::float', layout='floating')]
