from libqtile.config import Group, Match

www = { 'layout': 'treetab', 'matches': [Match(wm_class=['Vivaldi-stable', 'Brave-browser', 'firefox'])]}
management = { 'layout': 'max', 'matches': [Match(wm_class=['clickup'])]}
music = { 'layout': 'monadtall', 'matches': [Match(wm_class=['spotify'])]}
docs = { 'layout': 'monadtall', 'matches': [Match(wm_class=['Logseq', 'org.jabref.gui.JabRefMain'])]}
comm = { 'layout': 'monadtall', 'matches': [Match(wm_class=['Ferdium'])]}

# groups = [Group(' '+ u'\u2081', layout='monadtall'),
#         Group(' '+ u'\u2082', **www),
#         Group('華'+ u'\u2083', **docs),
#         Group(' '+ u'\u2084', **comm),
#         Group(' '+ u'\u2085', **music),
#         Group(' '+ u'\u2086', **management),
#         Group(' '+ u'\u2087', layout='monadtall'),
#         Group('  '+ u'\u2088', layout='floating')]

groups = [Group('1::dev', layout='monadtall'),
        Group('2::www', **www),
        Group('3::docs', **docs),
        Group('4::comm', **comm),
        Group('5::music', **music),
        Group('6::ctrl', **management),
        Group('7::sys', layout='monadtall'),
        Group('8::float', layout='floating')]
