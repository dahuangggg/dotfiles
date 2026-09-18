export VIRTUAL_ENV_DISABLE_PROMPT=1
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

(( ${+commands[starship]} )) && eval "$(starship init zsh)"
