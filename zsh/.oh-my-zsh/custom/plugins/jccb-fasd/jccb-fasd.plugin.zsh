# check if fasd is installed
if (( ! ${+commands[fasd]} )); then
  return
fi

fasd_cache="${ZSH_CACHE_DIR}/fasd-init-cache"
if [[ "$commands[fasd]" -nt "$fasd_cache" || ! -s "$fasd_cache" ]]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install \
    zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

function jccb_zz {
  ret=$(fasd -Rdl "$1" | fzf --height=10 --layout=reverse -0 -1) && cd "$ret"
}
alias zz=jccb_zz
