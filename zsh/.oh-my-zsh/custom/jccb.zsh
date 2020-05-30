ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

#################################################################
# History Setup
#################################################################
HISTSIZE=2000
SAVEHIST=2000

setopt HIST_FCNTL_LOCK
#setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY
setopt HIST_REDUCE_BLANKS
#setopt HIST_SAVE_NO_DUPS
setopt NO_SHARE_HISTORY
setopt INC_APPEND_HISTORY
unsetopt correct_all


# bindkey "^R" history-incremental-pattern-search-backward
# bindkey "^S" history-incremental-pattern-search-forward

#################################################################
# Aliases
#################################################################

alias zshrc='${=EDITOR} ~/.zshrc'

alias tree='tree -C'
alias clean='rm *~ .*~ core *.bak'

alias ls="ls -FG"
alias ll='ls -lh'
alias lla='ls -lah'
alias top="htop"
alias du='du -ch --max-depth=1'
# alias isodate='date +%Y%m%d'
# alias -g GG='| grep'
# alias -g GGV='| grep -v'
# alias -g HH='| head'
# alias -g TT='| tail'
# alias -g TNAME='--format="table(name)"'
alias epar='env_parallel'
alias tryepar='env_parallel --dry-run'
alias par='parallel'
alias trypar='parallel --dry-run'
GECEPE=529325294915
JCCBBILLING=015E9E-0F5C59-2487B7
alias gc='gcloud'
alias gce='gc compute'
alias gcei='gc compute instances'
alias gcssh='gce ssh'
alias gcsshiap="gcssh --tunnel-through-iap"
alias tf='terraform'
alias greauth="gcloud organizations list"
alias gke='gcloud container'
alias gkecred='gke clusters get-credentials'
alias gkec='gke clusters'
alias kcompload='source <(kubectl completion zsh)'

# alias dud='gdu -d 1 -h'
# alias duf='gdu -sh *'
# alias fd='gfind . -type d -name'
# alias ff='gfind . -type f -name'
alias hgrep="fc -El 0 | grep"
alias rehist='fc -RI' # reload history
alias dv='dirs -v | head -20'

#################################################################
# interactive comments
#################################################################
setopt INTERACTIVE_COMMENTS
bindkey '^[#' pound-insert


#################################################################
# EDITOR, VISUAL and Emacs utils
#################################################################

# open a dired window for the current directory
dired() {
    eeval -e "(dired \"$PWD\")"
}

magit() {
    eeval "(magit-status \"$PWD\")" > /dev/null
}

#################################################################
# Misc
#################################################################
# Move to where the arguments belong.
after-first-word() {
  zle beginning-of-line
  zle forward-word
}
zle -N after-first-word
bindkey "^X1" after-first-word

# Complete in history with M-/, M-,
# zstyle ':completion:history-words:*' list no
# zstyle ':completion:history-words:*' menu yes
# zstyle ':completion:history-words:*' remove-all-dups yes
# bindkey "\e/" _history-complete-older
# bindkey "\e," _history-complete-newer

# Quote stuff that looks like URLs automatically.
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

HISTORY_SUBSTRING_SEARCH_FUZZY=1
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down


ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HISTORY_IGNORE=30

src() {
    local cache="$ZSH_CACHE_DIR"
    autoload -U compinit zrecompile
    compinit -i -d "${ZSH_COMPDUMP}"

    for f in ${ZDOTDIR:-~}/.zshrc "${ZSH_COMPDUMP}"; do
        zrecompile -p $f && command rm -f $f.zwc.old
    done

    # Use $SHELL if available; remove leading dash if login shell
    [[ -n "$SHELL" ]] && exec ${SHELL#-} || exec zsh
}
