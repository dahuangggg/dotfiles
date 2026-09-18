# Surge proxy
proxy_on() {
  export https_proxy='http://127.0.0.1:6152'
  export http_proxy='http://127.0.0.1:6152'
  export all_proxy='socks5://127.0.0.1:6153'
  export NO_PROXY='localhost,127.0.0.1,localaddress,.local,.localdomain.com'
  echo 'Proxy ON'
}

proxy_off() {
  unset https_proxy http_proxy all_proxy NO_PROXY
  echo 'Proxy OFF'
}

proxy_status() {
  [[ -n "$http_proxy" ]] && echo 'Proxy ON' || echo 'Proxy OFF'
}

# Follow yazi directory changes after it exits.
y() {
  local yazi_cwd_file yazi_cwd
  yazi_cwd_file="$(mktemp -t yazi-cwd.XXXXXX)"
  command yazi "$@" --cwd-file="$yazi_cwd_file"
  if [[ -f "$yazi_cwd_file" ]]; then
    IFS= read -r -d '' yazi_cwd < "$yazi_cwd_file"
    [[ -n "$yazi_cwd" && "$yazi_cwd" != "$PWD" ]] && builtin cd -- "$yazi_cwd"
    rm -f -- "$yazi_cwd_file"
  fi
}

# Personal toolchains can be added in ~/.zshrc.local.
