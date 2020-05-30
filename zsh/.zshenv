skip_global_compinit=1
export VIRTUALENVWRAPPER_PYTHON=$HOME/homebrew/bin/python3
(ssh-add -l | grep roam >/dev/null) || /usr/bin/ssh-add -A
path=($HOME/bin $HOME/homebrew/bin $HOME/google-cloud-sdk/bin $path)
