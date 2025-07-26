if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZIM_HOME=~/.zim
ZIM_CONFIG_FILE=~/.zim/.zimrc

HISTSIZE=100000
SAVEHIST=100000
DIRSTACKSIZE=100

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi

source ${ZIM_HOME}/init.zsh


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


# if [[ "$OSTYPE" =~ "^darwin.*" ]] ; then
#     FPATH=$HOME/homebrew/share/zsh/site-functions:$FPATH
#     export FZF_BASE=$HOME/homebrew/opt/fzf
#     export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
#     export FZF_ALT_C_COMMAND="fd --type d --strip-cwd-prefix"
# elif [[ "$OSTYPE" =~ "^linux.*" ]]; then
#     export FZF_DEFAULT_COMMAND='fdfind --type f --strip-cwd-prefix'
#     export FZF_ALT_C_COMMAND="fdfind --type d --strip-cwd-prefix"
# fi
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

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


# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_TITLE="true"
HIST_STAMPS="yyyy-mm-dd"

alias ls="ls -FG"
alias ll='ls -lh'
alias lla='ls -lah'
alias epar='env_parallel'
alias tryepar='env_parallel --dry-run'
alias par='parallel'
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
alias gwhereis='gcloud help --'
alias gadc='gcloud auth application-default login'
alias gadcu='gcloud auth login --update-adc $(gcloud config get-value core/account)'
alias adcwhoami='curl -s "https://oauth2.googleapis.com/tokeninfo?access_token=$(gcloud auth application-default print-access-token)" | jq -r .email'
alias gwhoami='curl -s "https://oauth2.googleapis.com/tokeninfo?access_token=$(gcloud auth print-access-token)" | jq -r .email'

alias hgrep="fc -El 0 | grep"
alias rehist='fc -RI' # reload history
function dv {
  d=$(dirs -v | fzf --with-nth 2 | awk '{print $1}')
  cd "-${d}"
}

#function e()      { $EMACS_PLUGIN_LAUNCHER --eval "(progn (select-frame-set-input-focus (selected-frame)) (find-file \"$1\"))"; }
function ediff()  { $EMACS_PLUGIN_LAUNCHER -n --eval "(progn (select-frame-set-input-focus (selected-frame)) (ediff-files \"$1\" \"$2\"))"; }
function edired() { $EMACS_PLUGIN_LAUNCHER -n --eval "(progn (select-frame-set-input-focus (selected-frame)) (dired \"$1\"))"; }
function emagit() { $EMACS_PLUGIN_LAUNCHER -n --eval "(progn (select-frame-set-input-focus (selected-frame)) (magit-status \"$1\"))"; }
# function ekill()  { emacsclient --eval '(save-buffers-kill-emacs)'; }

HISTORY_SUBSTRING_SEARCH_FUZZY=1
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HISTORY_IGNORE=30

function _emacs_action() {
 emacsclient -u --eval "($1)"
 (( $+commands[osascript] )) && osascript -e "tell application \"Emacs\" to activate"
 (( $+commands[swaymsg] )) && swaymsg '[app_id="emacs"] focus'
}

alias magit="_emacs_action magit"
alias dired="_emacs_action dired-jump"

if [ "$SHORT_HOST" = "jccb-macbookpro3" ] ; then
    export CLOUDSDK_PYTHON="/Users/jccb/bin/gcloudvenv/bin/python"
    export CLOUDSDK_PYTHON_SITEPACKAGES=1
    source $HOME/google-cloud-sdk/completion.zsh.inc
fi

if [ "$SHORT_HOST" = "jccb-mac" ] ; then
    source $HOME/google-cloud-sdk/completion.zsh.inc
fi

source ~/.p10k.zsh
