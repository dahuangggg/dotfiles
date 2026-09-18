ZSH_PLUGIN_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"

_zplugin_load() {
  local repository="$1"
  local name="${repository:t}"
  local directory="$ZSH_PLUGIN_DIR/$name"

  if [[ ! -d "$directory/.git" ]]; then
    mkdir -p "$ZSH_PLUGIN_DIR"
    echo "Installing $name..."
    git clone --depth=1 "https://github.com/$repository.git" "$directory" || return 1
  fi

  source "$directory/$name.plugin.zsh"
}

zplugin-update() {
  local plugin_directory
  for plugin_directory in "$ZSH_PLUGIN_DIR"/*(/); do
    echo "Updating ${plugin_directory:t}..."
    git -C "$plugin_directory" pull --ff-only
  done
}

_zplugin_load zsh-users/zsh-autosuggestions
_zplugin_load zsh-users/zsh-history-substring-search
_zplugin_load jeffreytse/zsh-vi-mode
_zplugin_load zdharma-continuum/fast-syntax-highlighting
