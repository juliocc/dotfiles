export HOMEBREW_NO_ANALYTICS=1
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -f "$HOME/.zprofile.local" ]] && source "$HOME/.zprofile.local"
