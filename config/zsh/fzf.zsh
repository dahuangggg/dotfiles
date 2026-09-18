if ! (( ${+commands[fd]} && ${+commands[fzf]} )); then
  return
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height=60% --layout=reverse --border=rounded --preview-window=right:65%:wrap:border-left'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=plain,numbers --line-range=:500 {}'"

eval "$(fzf --zsh)"

# Ctrl-F searches files without hidden entries; Ctrl-T includes them.
_fzf_file_no_hidden() {
  local selected_file
  selected_file="$(fd --type f --strip-cwd-prefix | fzf \
    --preview 'bat --color=always --style=plain,numbers --line-range=:500 {}')" || return
  LBUFFER+="${(q)selected_file}"
  zle reset-prompt
}
zle -N _fzf_file_no_hidden
