#!/usr/local/bin/python3
from pathlib import Path
import re
import os.path
from collections import Counter
import sys


c = Counter()
r1 = re.compile(r'includegraphics[^{}]*{([^(={}]+)}')
r2 = re.compile(r'!\[[^\[\]]*\]\(([^()]*)\)')
r3 = re.compile(r'input{([^(={}]+)}')
all_used = set()
for file in Path('.').glob('*'):
    if file.suffix not in {'.md', '.tex'}:
        continue
    with file.open() as f:
        corpus = f.read()

    for fig_path in r1.findall(corpus) + r2.findall(corpus):
        all_used.add(fig_path)
        if not os.path.isfile(fig_path):
            print('ALERT', str(file), fig_path)
            c[str(file)] += 1
    for fig_path in r3.findall(corpus):
        fig_path += '.tex'
        all_used.add(fig_path)
        if not os.path.isfile(fig_path):
            print('ALERT', str(file), fig_path)
            c[str(file)] += 1

all_available = set([str(path) for path in (list(Path('figures').glob('*')) +
                                            list(Path('tables').glob('*')))
                     if '/.' not in str(path) and
                     not str(path).endswith('.tex')])
print('# USELESS', len(all_available - all_used))
for useless in sorted(all_available - all_used):
    print(useless)

for k, v in c.most_common(5):
    print(k, v)
