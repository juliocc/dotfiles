if [ "$SHORT_HOST" = "jccb-macbookpro" ] ; then
    export CLOUDSDK_PYTHON=python3.9
    export CLOUDSDK_PYTHON_SITEPACKAGES=1
    source $HOME/google-cloud-sdk/completion.zsh.inc
    #. `which env_parallel.zsh`
fi

if [ "$SHORT_HOST" = "jccb-macbookpro3" ] ; then
    export CLOUDSDK_PYTHON="/Users/jccb/.virtualenvs/gcloud/bin/python"
    export CLOUDSDK_PYTHON_SITEPACKAGES=1
    source $HOME/google-cloud-sdk/completion.zsh.inc
fi
