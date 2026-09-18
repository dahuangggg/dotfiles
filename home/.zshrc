# Minimal zsh entrypoint. Feature configuration lives in ~/.config/zsh/.
[[ $- != *i* ]] && return

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

# PATH and completion
typeset -U path PATH fpath FPATH
path=(
  "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/file-formula/bin"
  "$HOME/.local/bin"
  "$HOME/.bun/bin"
  "$HOME/.antigravity/antigravity/bin"
  "$path[@]"
)
[[ -n "$HOMEBREW_PREFIX" ]] && fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" "$fpath[@]")

autoload -Uz compinit
ZSH_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZSH_CACHE_HOME"
compinit -d "$ZSH_CACHE_HOME/zcompdump"

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_CACHE_HOME"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Tool initialization
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"
(( ${+commands[zoxide]} )) && eval "$(zoxide init zsh)"
(( ${+commands[fnm]} )) && eval "$(fnm env --use-on-cd)"
[[ -f "$HOME/.config/broot/launcher/bash/br" ]] && source "$HOME/.config/broot/launcher/bash/br"

export BUN_INSTALL="$HOME/.bun"
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

[[ -f "$HOME/.openclaw/completions/openclaw.zsh" ]] &&
  source "$HOME/.openclaw/completions/openclaw.zsh"

if [[ "$TERM_PROGRAM" == "kiro" ]] && (( ${+commands[kiro]} )); then
  source "$(kiro --locate-shell-integration-path zsh)"
fi

(( ${+commands[thefuck]} )) && eval "$(thefuck --alias)"

# Feature modules
ZSH_CONFIG_HOME="$HOME/.config/zsh"
source "$ZSH_CONFIG_HOME/fzf.zsh"
source "$ZSH_CONFIG_HOME/aliases.zsh"
source "$ZSH_CONFIG_HOME/functions.zsh"
source "$ZSH_CONFIG_HOME/bindings.zsh"
source "$ZSH_CONFIG_HOME/plugins.zsh"
source "$ZSH_CONFIG_HOME/prompt.zsh"

unset ZSH_CONFIG_HOME ZSH_CACHE_HOME

# Machine-specific settings and credentials stay outside this repository.
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
