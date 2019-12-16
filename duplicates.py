#!/usr/bin/python3
from collections import Counter, defaultdict
from pathlib import Path
import sys
print('wow', len(list(Path('.').rglob('*'))))
# sys.exit(0)


def describe(path):
    name = path.name
    size = path.stat().st_size
    if name == '.DS_Store':
        return
    nb_sizes = len(names_sizes[name])
    print(name, c[name], nb_sizes)
    if nb_sizes > 1:
        for size, paths in names_sizes[name].items():
            print(size, paths)
            if str(path) in paths:
                print('PRECIOUS' if len(paths) == 1 else 'OK', name)


c = Counter()
sizes = defaultdict(set)
names_sizes = defaultdict(lambda: defaultdict(set))
for path in Path('.').rglob('*'):
    c[path.name] += 1
    size = path.stat().st_size
    sizes[size].add(str(path))
    names_sizes[path.name][size].add(str(path))

# print('wow', len(c))
# for path, v in c.most_common(5):
#     describe(path)
# print()

for path in Path('.').glob('*'):
    # describe(path)
    size = path.stat().st_size
    if len(sizes[size]) > 1:
        print(size, sizes[size])
