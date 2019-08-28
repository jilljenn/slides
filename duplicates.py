from collections import Counter, defaultdict
from pathlib import Path
import sys
print('wow', len(list(Path('.').rglob('*'))))
# sys.exit(0)


def describe(file):
    name = file.name
    size = file.stat().st_size
    if name == '.DS_Store':
        return
    nb_sizes = len(names_sizes[name])
    print(name, c[name], nb_sizes)
    if nb_sizes > 1:
        for size, paths in names_sizes[name].items():
            print(size, paths)
            if str(file) in paths:
                print('PRECIOUS' if len(paths) == 1 else 'OK', name)


c = Counter()
sizes = defaultdict(set)
names_sizes = defaultdict(lambda: defaultdict(set))
for file in Path('.').rglob('*'):
    c[file.name] += 1
    size = file.stat().st_size
    sizes[size].add(str(file))
    names_sizes[file.name][size].add(str(file))

# print('wow', len(c))
# for file, v in c.most_common(5):
#     describe(file)
# print()

for file in Path('.').glob('*'):
    # describe(file)
    size = file.stat().st_size
    if len(sizes[size]) > 1:
        print(size, sizes[size])
