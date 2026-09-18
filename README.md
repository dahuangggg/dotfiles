# dotfiles

Personal macOS configuration for Zsh, Yazi, Ghostty, Zed, Starship, Neovim, Kitty and Rime (Squirrel).

## Install

Install Homebrew first, then clone this repository and run:

```sh
git clone https://github.com/dahuangggg/dotfiles.git
cd dotfiles
brew bundle --file Brewfile
python3 install.py
python3 install.py --apply
```

The first installer command previews changes. The second copies configuration files and backs up replaced files under `~/.local/state/dotfiles/backups/<timestamp>/`, preserving their relative paths. Identical files are skipped. Unrelated files are left in place. Symlinked destination directories are rejected; resolve these manually before installing. Quit editors and terminals before applying, then reopen them.

To install only some applications:

```sh
python3 install.py --only zsh starship ghostty
python3 install.py --apply --only zsh starship ghostty
```

To restore a replaced file, copy its matching file from the printed backup directory to its original path. Files newly created by the installer have no backup; remove them individually if needed.

## Agent setup checklist

1. Inspect the OS and existing configuration. This bundle targets macOS and `~/.config`; custom XDG directories and Linux require adaptation. Do not assume the original user's paths exist.
2. Review `Brewfile`, install dependencies, and preview `install.py`. Apply only the requested applications. Never run package-manager cleanup.
3. Start an interactive Zsh. Its plugin loader downloads four plugins from GitHub on first use. Starship, fzf, bat, fd, lsd and zoxide provide the shell integrations. Proxy helpers are manual and assume local ports 6152/6153; adjust them for the destination machine.
4. Start Neovim and allow lazy.nvim and Mason to install plugins and language tools. The committed `lazy-lock.json` records plugin revisions; use `:Lazy restore` to restore them. Run `:checkhealth`. Java tooling requires JDK 21. Copilot requires a separate `:Copilot setup` login.
5. Yazi flavors are included with their licenses. Test navigation, `y` in Zsh, and file previews. Its custom Lua layout depends on Yazi APIs and should be checked after upgrades.
6. Open Zed and verify fonts, Java and extensions. Personal SSH connections, custom model endpoints and Agent server definitions must be configured separately. Account-backed AI features require login.
7. Verify Ghostty and Kitty appearance. Monaco is supplied by macOS; JetBrains Mono Nerd Font supplies icons. Check for an existing Ghostty config under `~/Library/Application Support/com.mitchellh.ghostty/` that may override these settings; review it before changing it.

## Layout

- `home/`: Zsh startup files.
- `config/`: the eight selected application configurations; Neovim uses the active `nvim` configuration.
- `Brewfile`: applications and CLI dependencies, without importing additional application configurations.
- `install.py`: preview, selective installation and backups.

Keep credentials and machine-specific shell functions in `~/.zshrc.local` or `~/.zprofile.local`. The installer does not create or upload these files. Optional integrations activate only when their local files or commands exist. Personal Java/Ruby project wrappers can be added to the local file as needed.

Application settings preserve the original preferences, including Zed's workspace trust setting; review them for the destination environment. Third-party Yazi themes retain their own licenses.

## Rime / Squirrel

The Rime bundle contains the local Rime Ice schemas, public dictionaries, Lua modules, OpenCC data and Squirrel appearance/key preferences. Its upstream license is retained in `config/rime/LICENSE`.

```sh
brew install --cask squirrel
python3 install.py --only rime
python3 install.py --apply --only rime
```

Rime files are installed into `~/Library/Rime/`. Add or enable Squirrel in macOS Input Sources (log out and back in if macOS requests it), select it, then choose Deploy / 重新部署 from the input menu. Select Rime Ice / 雾凇拼音 in the schema menu. Verify Chinese input, six candidates per page, Shift behavior and light/dark appearance.

Personal phrase files, learned user dictionaries, sync data, installation IDs, build outputs and backups are excluded. Existing personal files on the destination are preserved. The three cold-word preference tables ship empty and are only installed if missing; they can accumulate personal word preferences, so do not copy them back into a public repository. Create `custom_phrase.txt`, `custom_phrase_double.txt` or `custom_phrase_t9.txt` locally if you want custom phrases.

The installer does not trigger deployment or modify macOS input sources automatically. On Linux, adapt the destination directory and omit Squirrel-specific settings.
