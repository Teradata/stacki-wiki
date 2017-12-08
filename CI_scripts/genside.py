#!/usr/bin/env python
from pathlib import Path


excludes = ['Reference', 'ipmi', 'stacki-pro', '.sass-cache']
order = [
        'Overview',
        'QuickStart',
        'Terms', 
        'Installation',
        'Configuration',
        'Customization',
        'Workflows',
        'Frequently Asked Questions',
        'Developer',
        'Licenses',
        'Reference',
        'Guano',
        ]

for o in order:
    p = Path('./%s' % o)
    if p.is_dir(): #and p.name not in excludes:
        print('* {}'.format(p))
        for x in p.iterdir():
            if x.is_file() and x.name.endswith('.md') \
                and not x.name.startswith('_') \
                and not x.name.islower():
                    print('  * [{}]({})'.format(x.stem.replace('-',' '),x.stem))
    else:
        print('* {}'.format(p))
