"""Compare two OpenFOAM time dirs cell-by-cell (same mesh => same ordering)."""
import re, sys

def read_internal(path):
    txt = open(path).read()
    m = re.search(r'internalField\s+nonuniform\s+List<\w+>\s*\n(\d+)\s*\n\(\s*\n?(.*)\n\)\s*;', txt, re.S)
    if not m:
        raise ValueError(f'no internalField in {path}')
    n = int(m.group(1))
    nums = [float(x) for x in re.findall(r'[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?', m.group(2))]
    assert len(nums) >= n, f'{path}: found {len(nums)} numbers, expected {n}'
    return nums[:n]

def stats(a, b, name):
    n = len(a); assert len(b) == n
    diffs = [abs(x - y) for x, y in zip(a, b)]
    mx = max(diffs); mean = sum(diffs) / n
    rng = max(a) - min(a)
    print(f'{name}: cells={n} maxAbsDiff={mx:.3e} meanAbsDiff={mean:.3e} fieldRange={rng:.3e} relMax={mx/rng:.3e}')

if __name__ == '__main__':
    t = sys.argv[1] if len(sys.argv) > 1 else '200'
    for f in ['U', 'p', 'k', 'epsilon']:
        try:
            a = read_internal(f'/home/shared/openfoam/solo_run/{t}/{f}')
            b = read_internal(f'/home/shared/openfoam/test1/{t}/{f}')
            stats(a, b, f'{f}@{t}')
        except Exception as e:
            print(f'{f}@{t}: SKIP ({e})')
