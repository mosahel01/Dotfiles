import re

# ── Config ────────────────────────────────────────────────────────────────────

HTML_FILE = 'lua/colors/output.html'
OUT_FILE  = 'lua/colors/homegrown/colors_reference.txt'

SHADE_FILES = [
    ('white',   'lua/colors/homegrown/shades/white.lua'),
    ('black',   'lua/colors/homegrown/shades/black.lua'),
    ('gray',    'lua/colors/homegrown/shades/gray.lua'),
    ('brown',   'lua/colors/homegrown/shades/brown.lua'),
    ('pink',    'lua/colors/homegrown/shades/pink.lua'),
    ('magenta', 'lua/colors/homegrown/shades/magenta.lua'),
    ('purple',  'lua/colors/homegrown/shades/purple.lua'),
    ('indigo',  'lua/colors/homegrown/shades/indigo.lua'),
    ('blue',    'lua/colors/homegrown/shades/blue.lua'),
    ('cyan',    'lua/colors/homegrown/shades/cyan.lua'),
    ('green',   'lua/colors/homegrown/shades/green.lua'),
    ('yellow',  'lua/colors/homegrown/shades/yellow.lua'),
    ('orange',  'lua/colors/homegrown/shades/orange.lua'),
    ('red',     'lua/colors/homegrown/shades/red.lua'),
]

# Line ranges for each color section in the Wikipedia HTML
SECTION_BOUNDS = [
    ('Red',           790, 797),
    ('Orange',        797, 804),
    ('Yellow',        804, 811),
    ('Green',         811, 820),
    ('Cyan',          820, 827),
    ('Blue',          827, 834),
    ('Indigo',        834, 843),
    ('Violet_purple', 843, 853),
    ('Magenta',       853, 860),
    ('Pink',          860, 867),
    ('Brown',         867, 876),
    ('White',         876, 883),
    ('Gray',          883, 890),
    ('Black',         890, 900),
]

# Overrides where the Wikipedia key doesn't cleanly map to the Lua key
HARD = {
    'off_red':          '#FE0000',
    'rose_taupe':       '#905D5D',
    'scarlet':          '#FF2400',
    'alizaran_crimson': '#E32636',
}

# Lua file key → canonical Wikipedia key (typos + naming differences)
ALIASES = {
    'rosewoood':            'rosewood',
    'rosewoord':            'rosewood',
    'avacado':              'avocado',
    'biege':                'beige',
    'atice_blue':           'alice_blue',
    'mightnight_green':     'midnight_green',
    'might_green':          'mint_green',
    'blondi_blue':          'bondi_blue',
    'lavendar_mist':        'lavender_mist',
    'calestial_blue':       'celestial_blue',
    'franch_mauve':         'french_mauve',
    'fairy_tail':           'fairy_tale',
    'colral_pink':          'coral_pink',
    'misty_rost':           'misty_rose',
    'papaya_white':         'papaya_whip',
    'burnt_amber':          'burnt_umber',
    'safery_orange':        'safety_orange',
    'desert_sand_color':    'desert_sand',
    'tripoical_indigo':     'tropical_indigo',
    'oatlmeal':             'oatmeal',
    'davys_gray':           'davy_s_gray',
    'paynes_gray':          'payne_s_gray',
    'orange_chrome':        'chrome_orange',
    'tigers_eye':           'tiger_s_eye',
    'vermillion':           'vermilion',
    'hookers_green':        'hooker_s_green',
    'indigo_colorwheel':    'indigo_color_wheel',
    'lavender_crayola_I':   'lavender_crayola_i',
    'razzle_dazzle_purple': 'razzle_dazzle_rose',
}

# ── HTML parsing ──────────────────────────────────────────────────────────────

def to_lua_key(name):
    name = name.lower()
    name = re.sub(r'[^a-z0-9]+', '_', name)
    return name.strip('_')

def extract_section(html_lines, start, end):
    chunk = '\n'.join(html_lines[start - 1:end - 1])
    name_rows  = re.findall(r'vertical-align:bottom[^<]*<.*?</tr>', chunk, re.DOTALL)
    color_rows = re.findall(r'<tr><td style="background:#[A-Fa-f0-9]{6}!important.*?</tr>', chunk, re.DOTALL)
    result = {}
    for nr, cr in zip(name_rows, color_rows):
        names = [re.sub(r'<[^>]+>', '', n).strip()
                 for n in re.findall(r'<td[^>]*>.*?>(.*?)</a></td>', nr)]
        hexes = re.findall(r'background:(#[A-Fa-f0-9]{6})!important', cr)
        for name, hex_code in zip(names, hexes):
            result[to_lua_key(name)] = hex_code.upper()
    return result

def build_lookup(html_path):
    with open(html_path) as f:
        lines = f.read().split('\n')
    mega = {}
    for _, start, end in SECTION_BOUNDS:
        for k, v in extract_section(lines, start, end).items():
            if k not in mega:
                mega[k] = v
    return mega

def lookup(mega, key):
    if key in HARD:
        return HARD[key]
    canonical = ALIASES.get(key, key)
    return mega.get(canonical)

# ── Output generation ─────────────────────────────────────────────────────────

def generate(base_dir='.'):
    mega = build_lookup(f'{base_dir}/{HTML_FILE}')
    lines_out = []

    for name, rel_path in SHADE_FILES:
        with open(f'{base_dir}/{rel_path}') as f:
            content = f.read()

        lines_out.append('─' * 30)
        lines_out.append(f'  {name.upper()}.LUA')
        lines_out.append('─' * 30)

        for m in re.finditer(r'^\s+(\w+)\s*=\s*"(#[A-Fa-f0-9]*)"', content, re.MULTILINE):
            key, existing = m.group(1), m.group(2)
            wiki_val = lookup(mega, key)
            if wiki_val:
                lines_out.append(f'{key} = "{wiki_val}",')
            elif existing and existing != '#':
                lines_out.append(f'{key} = "{existing}"')
            else:
                lines_out.append(f'  {key} = "#??????",  -- not on Wikipedia page')

        lines_out.append('')

    out_path = f'{base_dir}/{OUT_FILE}'
    with open(out_path, 'w') as f:
        f.write('\n'.join(lines_out))

    total     = sum(1 for l in lines_out if re.match(r'  \w+ = "#', l))
    not_found = sum(1 for l in lines_out if 'not on Wikipedia' in l)
    print(f'written → {out_path}')
    print(f'entries : {total}  |  not found : {not_found}')
    for l in lines_out:
        if 'not on Wikipedia' in l:
            print(f'  missing: {l.strip()}')


if __name__ == '__main__':
    import sys
    base = sys.argv[1] if len(sys.argv) > 1 else '/Users/andrewwellington/config/nvim'
    generate(base)
