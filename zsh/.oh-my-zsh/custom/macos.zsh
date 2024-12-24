if [ "$SHORT_HOST" = "jccb-macbookpro3" ] ; then
    export CLOUDSDK_PYTHON="/Users/jccb/.pyenv/versions/gcloud312/bin/python"
    export CLOUDSDK_PYTHON_SITEPACKAGES=1
    source $HOME/google-cloud-sdk/completion.zsh.inc
fi


export PATH="$HOME/homebrew/opt/curl/bin:$PATH"
