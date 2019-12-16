#!/usr/bin/python3
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
weight = Counter()

for file in Path('.').glob('*'):
    if file.suffix not in {'.md', '.tex'}:
        continue
    with file.open() as f:
        corpus = f.read()

    for fig_path in r1.findall(corpus) + r2.findall(corpus):
        fig_path = fig_path.replace('https://jiji.cat/tmp/slides/', '')
        size = Path(fig_path).stat().st_size
        weight[(fig_path, file)] = size  # You're gonna carry that weight
        all_used.add(fig_path)
        if not os.path.isfile(fig_path):
            print('ALERT', str(filename), fig_path)
            c[str(filename)] += 1
    for fig_path in r3.findall(corpus):
        fig_path += '.tex'
        all_used.add(fig_path)
        if not os.path.isfile(fig_path):
            print('ALERT', str(filename), fig_path)
            c[str(filename)] += 1

# Find the useless figures
all_available = set([str(path) for path in (list(Path('figures').glob('*')) +
                                            list(Path('tables').glob('*')))
                     if '/.' not in str(path) and
                     not str(path).endswith('.tex')])
print('# USELESS', len(all_available - all_used))
for useless in sorted(all_available - all_used):
    print(useless)

for k, v in c.most_common(5):
    print(k, v)

print('# HEAVY')
for (fig, path), v in weight.most_common(10):
    print(fig, path.name, v)
