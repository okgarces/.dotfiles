-- Color scheme
base03 = { '#242424', 235 }
base023 = { '#353535', 236 }
base02 = { '#444444', 238 }
base01 = { '#585858', 240 }
base00 = { '#666666', 242  }
base0 = { '#808080', 244 }
base1 = { '#969696', 247 }
base2 = { '#a8a8a8', 248 }
base3 = { '#d0d0d0', 252 }
yellow = { '#cae682', 180 }
orange = { '#e5786d', 173 }
red = { '#e5786d', 203 }
magenta = { '#f2c68a', 216 }
blue = { '#8ac6f2', 117 }
dark_blue = {'5f87af', 67}
cyan = blue
green = { '#87d700', 112 }

-- p array
p = {
  normal = {},
  inactive = {},
  insert = {},
  replace = {},
  visual = {},
  tabline = {},
}
p.normal.left = { { base02, blue }, { base3, base01 } }
p.normal.right = { { base02, base0 }, { base1, base01 } }

-- { { <font color>, <background> } } "
p.inactive.right = { { base02, dark_blue }, { base02, dark_blue } }
p.inactive.left =  { { base1, base02 }, { base00, base023 } }
p.insert.left = { { base02, green, 'bold' }, { base3, base01 } }
p.replace.left = { { base023, red }, { base3, base01 } }
p.visual.left = { { base02, magenta }, { base3, base01 } }
p.normal.middle = { { base2, base02 } }
p.inactive.middle = { { base1, base023 } }
p.tabline.left = { { base3, base00 } }
p.tabline.tabsel = { { base3, base03 } }
p.tabline.middle = { { base2, base02 } }
p.tabline.right = { { base2, base00 } }
p.normal.error = { { base03, red } }
p.normal.warning = { { base023, yellow } }

vim.g['lightline#colorscheme#wombat#palette'] = vim.fn['lightline#colorscheme#flatten'](p)
vim.g['lightline'] = { colorscheme = 'wombat'}
print "--- Finishing color theme wombat ---"

return {} 
