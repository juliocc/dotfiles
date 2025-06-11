if [ "$SHORT_HOST" = "jccb-macbookpro3" ] ; then
    export CLOUDSDK_PYTHON="/Users/jccb/bin/gcloudvenv/bin/python"
    export CLOUDSDK_PYTHON_SITEPACKAGES=1
    source $HOME/google-cloud-sdk/completion.zsh.inc
fi

if [ "$SHORT_HOST" = "jccb-mac" ] ; then
    source $HOME/google-cloud-sdk/completion.zsh.inc
fi

export PATH="$HOME/homebrew/opt/curl/bin:$PATH"
