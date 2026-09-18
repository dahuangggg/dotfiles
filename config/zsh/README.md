# Zsh

The startup files load feature modules from `~/.config/zsh/`.

| Module | Purpose |
| --- | --- |
| aliases.zsh | File, shell and editor shortcuts |
| functions.zsh | Manual proxy helpers and the Yazi `y` wrapper |
| bindings.zsh | vi mode and custom keybindings |
| fzf.zsh | File and history search |
| plugins.zsh | Install and update four Zsh plugins |
| prompt.zsh | Load `~/.config/starship/starship.toml` |

`Ctrl-R` searches history, `Ctrl-T` searches files including hidden files, and `Ctrl-F` searches visible files. `Esc` enters vi normal mode. `Ctrl-\` toggles autosuggestions.

Use `reload` after edits, `y` to follow Yazi's working directory on exit, and `zplugin-update` to update plugins. The `p`/`po` helpers turn a local proxy on/off; configure its ports for your machine first. Agent aliases require their corresponding CLIs to be installed separately.

Put credentials, personal toolchain wrappers and machine-specific paths in `~/.zshrc.local`. Validate each file separately:

```zsh
for file in ~/.zshrc ~/.zshenv ~/.zprofile ~/.config/zsh/*.zsh; do
  zsh -n "$file" || break
done
```

See the repository README for installation and backup restoration.
