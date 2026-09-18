# zsh-vi-mode calls this after its constants are available.
zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
  ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_VI_HIGHLIGHT_BACKGROUND=none
  ZVM_VI_HIGHLIGHT_FOREGROUND=none
  ZVM_VI_HIGHLIGHT_EXTRASTYLE=none
}

# zsh-vi-mode resets bindings during initialization, so restore fzf and custom
# bindings in its supported hook.
zvm_after_init() {
  source "$HOME/.config/zsh/fzf.zsh"

  zmodload -F zsh/terminfo +p:terminfo

  bindkey -M viins '^[[1;5C' forward-word
  bindkey -M viins '^[[1;5D' backward-word
  bindkey -M viins '^R' fzf-history-widget
  bindkey -M viins '^T' fzf-file-widget
  bindkey -M viins '^F' _fzf_file_no_hidden
  bindkey -M viins '^\' autosuggest-toggle

  bindkey -M viins '^[[A' history-substring-search-up
  bindkey -M viins '^[[B' history-substring-search-down
  bindkey -M viins '^P' history-substring-search-up
  bindkey -M viins '^N' history-substring-search-down

  [[ -n "${terminfo[kcuu1]}" ]] && bindkey -M viins "${terminfo[kcuu1]}" history-substring-search-up
  [[ -n "${terminfo[kcud1]}" ]] && bindkey -M viins "${terminfo[kcud1]}" history-substring-search-down

  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
}
