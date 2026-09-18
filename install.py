#!/usr/bin/env python3
"""Copy selected configuration files, backing up every replaced file."""
import argparse
from datetime import datetime
from pathlib import Path
import shutil

ROOT = Path(__file__).resolve().parent
APPS = ('zsh', 'yazi', 'ghostty', 'zed', 'starship', 'nvim', 'kitty', 'rime')
p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--apply', action='store_true', help='write files (default: preview)')
p.add_argument('--target', type=Path, default=Path.home(), help='destination home directory')
p.add_argument('--only', nargs='+', choices=APPS, default=list(APPS))
a = p.parse_args()
home = a.target.expanduser().absolute()
backup = home / '.local/state/dotfiles/backups' / datetime.now().strftime('%Y%m%d-%H%M%S-%f')
files = []
for app in a.only:
    for src in sorted((ROOT / 'config' / app).rglob('*')):
        if src.is_file():
            destination = home / 'Library/Rime' if app == 'rime' else home / '.config' / app
            relative = src.relative_to(ROOT / 'config' / app)
            # Rime can write personal word preferences into these Lua tables.
            if app == 'rime' and relative.as_posix() in {
                'lua/cold_word_drop/reduce_freq_words.lua',
                'lua/cold_word_drop/drop_words.lua',
                'lua/cold_word_drop/hide_words.lua',
            } and (destination / relative).exists():
                continue
            files.append((src, destination / relative))
if 'zsh' in a.only:
    files += [(src, home / src.name) for src in sorted((ROOT / 'home').iterdir()) if src.is_file()]
# Refuse symlinked parent directories rather than writing outside the target home.
for src, dst in files:
    for parent in (home, *dst.relative_to(home).parents):
        candidate = parent if parent == home else home / parent
        if candidate.is_symlink():
            p.error(f'symlinked destination directory: {candidate}')
    if dst.is_dir():
        p.error(f'destination is a directory: {dst}')
for src, dst in files:
    if not dst.is_symlink() and dst.is_file() and src.read_bytes() == dst.read_bytes():
        continue
    print(('COPY ' if a.apply else 'PLAN ') + str(dst))
    if a.apply:
        if dst.exists() or dst.is_symlink():
            saved = backup / dst.relative_to(home)
            saved.parent.mkdir(parents=True, exist_ok=True)
            shutil.move(str(dst), str(saved))
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dst)
if a.apply:
    print(f'Complete. Backups, if needed: {backup}')
    if 'rime' in a.only:
        print('Rime: select Squirrel in macOS Input Sources and run Deploy from its menu.')
else:
    print('Preview only. Add --apply to install.')
