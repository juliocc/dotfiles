ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

#################################################################
# History Setup
#################################################################
HISTSIZE=100000
SAVEHIST=100000
DIRSTACKSIZE=100

setopt EXTENDED_HISTORY       # record timestamp of command in HISTFILE
setopt HIST_EXPIRE_DUPS_FIRST # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_FCNTL_LOCK        # record timestamp
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS       # ignore duplicated commands history list
setopt HIST_IGNORE_SPACE      # ignore commands that start with space
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks from each command line being added to the history.
setopt HIST_VERIFY            # show command with history expansion to user before running it
setopt INC_APPEND_HISTORY
setopt NO_SHARE_HISTORY
unsetopt correct_all

setopt MENU_COMPLETE

# bindkey "^R" history-incremental-pattern-search-backward
# bindkey "^S" history-incremental-pattern-search-forward

#################################################################
# fzf
#################################################################

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --preview 'tree -C {}'"
export UV_TOOL_BIN_DIR="$HOME/bin"

## fzf-tab specific
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

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
alias gc='gcloud'
alias gce='gc compute'
alias gcei='gc compute instances'
alias gcssh='gce ssh --ssh-key-expire-after=7d'
alias gcsshiap="gcssh --tunnel-through-iap"
alias greauth="gcloud organizations list"
alias gke='gcloud container'
alias gkecred='gke clusters get-credentials'
alias gkec='gke clusters'
alias kcompload='source <(kubectl completion zsh)'
alias tf='terraform'
alias tfa='tf apply'
alias tfar='tf apply -refresh=false'
alias tfara='tf apply -refresh=false -auto-approve'
alias tfi='tf init'
alias tfia='tfi && tfa'
alias tfiu='tf init -upgrade=true'
alias tfp='tf plan'
alias tfpr='tfp -refresh=false'
alias tfyolo='tfi && tfa -auto-approve'
alias tfyoloer='tfi && tfa -auto-approve -refresh=false'
alias kx=kubectx
alias gwhereis='gcloud help --'
alias gadc='gcloud auth application-default login'
alias gadcu='gcloud auth login --update-adc $(gcloud config get-value core/account)'
alias adcwhoami='curl -s "https://oauth2.googleapis.com/tokeninfo?access_token=$(gcloud auth application-default print-access-token)" | jq -r .email'
alias gwhoami='curl -s "https://oauth2.googleapis.com/tokeninfo?access_token=$(gcloud auth print-access-token)" | jq -r .email'

# alias dud='gdu -d 1 -h'
# alias duf='gdu -sh *'
# alias fd='gfind . -type d -name'
# alias ff='gfind . -type f -name'
alias hgrep="fc -El 0 | grep"
alias rehist='fc -RI' # reload history
#alias dv='dirs -v | head -20'
#alias dv="cd -\$(dirs -v | fzf --with-nth 2 | awk '{print $1}')"
function dv {
  d=$(dirs -v | fzf --with-nth 2 | awk '{print $1}')
  cd "-${d}"
}

#################################################################
# interactive comments
#################################################################
setopt INTERACTIVE_COMMENTS
bindkey '^X;' pound-insert


#################################################################
# EDITOR, VISUAL and Emacs utils
#################################################################

# open a dired window for the current directory
# dired() {
#     eeval -e "(dired \"$PWD\")"
# }

# magit() {
#     eeval "(magit-status \"$PWD\")" > /dev/null
# }

#function e()      { $EMACS_PLUGIN_LAUNCHER --eval "(progn (select-frame-set-input-focus (selected-frame)) (find-file \"$1\"))"; }
function ediff()  { $EMACS_PLUGIN_LAUNCHER -n --eval "(progn (select-frame-set-input-focus (selected-frame)) (ediff-files \"$1\" \"$2\"))"; }
function edired() { $EMACS_PLUGIN_LAUNCHER -n --eval "(progn (select-frame-set-input-focus (selected-frame)) (dired \"$1\"))"; }
function emagit() { $EMACS_PLUGIN_LAUNCHER -n --eval "(progn (select-frame-set-input-focus (selected-frame)) (magit-status \"$1\"))"; }
# function ekill()  { emacsclient --eval '(save-buffers-kill-emacs)'; }

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

function _emacs_action() {
 emacsclient -u --eval "($1)"
 (( $+commands[osascript] )) && osascript -e "tell application \"Emacs\" to activate"
 (( $+commands[swaymsg] )) && swaymsg '[app_id="emacs"] focus'
}

alias magit="_emacs_action magit"
alias dired="_emacs_action dired-jump"
