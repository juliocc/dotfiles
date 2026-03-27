skip_global_compinit=1

path_add() { [[ -d "$1" ]] && path=("$1" $path) }
path_add "$HOME/bin"
path_add "$HOME/.local/bin"

[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
