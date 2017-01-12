# Global Variables I want
export DEFAULT_USER='pvomelveny'
export EDITOR='vim'
export ALTERNATE_EDITOR='vi'
# Source Computer Local Variables
# Path to Antigen and Anaconda need to be here
if [ -f ".system_exports.zsh" ]; then
    source .custom_exports.zsh
fi

# Set vi mode
bindkey -v
export KEYTIMEOUT=1

if [ -n "$ANTIGEN_LOCATION" ]; then

    # Load Antigen
    source $ANTIGEN_LOCATION

    # Load the oh-my-zsh's library.
    antigen use oh-my-zsh

    #
    # Antigen Theme
    #

    antigen theme agnoster

    #
    # Antigen Bundles
    #

    antigen bundle aws
    antigen bundle git #https://github.com/robbyrussell/oh-my-zsh/wiki/Plugin:git
    antigen bundle pip
    antigen bundle python
    antigen bundle sudo
    antigen bundle tmux
    antigen bundle vi-mode
    antigen bundle zsh-users/zsh-syntax-highlighting


    # OSX Specific bundles
    if [[ `uname` == 'Darwin' ]]; then
        antigen bundle brew
        antigen bundle osx
    fi

    # End the anigen adding process
    antigen apply

fi

# Aliases

if hash nvim 2>/dev/null; then
    alias vim='nvim'
fi

if [[ `uname` == 'Darwin' ]]; then
    alias rstudio='open -a rstudio'
    alias finder='open -a Finder .'
fi


# GOPATH, points to the workspace directory for golang
export GOPATH=$HOME/go

# Add GOPATH's bin to to the general PATH
export PATH=$PATH:$GOPATH/bin

# Add mactex to the path on Macs
# Set up path to use MacTeX properly
if [[ `uname` == 'Darwin' ]]; then
    eval `/usr/libexec/path_helper -s`
    export PATH=/Library/TeX/texbin:$PATH
fi

# added by Anaconda3 4.0.0 installer
if [ -n "$ANACONDA_ROOT" ]; then
    export PATH=$ANACONDA_ROOT:$PATH
fi

