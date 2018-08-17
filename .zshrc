#####################
### Global Variables
##
export DEFAULT_USER='pvomelveny'
export EDITOR='emacs'
export ALTERNATE_EDITOR='vim'
# Source Computer Local Variables
if [ -f "$HOME/.system_exports" ]; then
    source "$HOME/.system_exports"
fi

############
### Aliases
##
alias ls='ls -G'
alias chrome='google-chrome-stable &'

if hash nvim 2>/dev/null; then
    alias vim='nvim'
fi


####################
### Plugin Manager
##
if [ -n "$ZPLUG_HOME" ]; then

    # Load Antigen
    source $ZPLUG_HOME/init.zsh

    ### Theme
    zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

    ### Colors
    zplug "chrissicool/zsh-256color", from:github

    ### Quality of Life
    zplug "modules/utility", from:prezto
    zplug "modules/directory", from:prezto
    zplug "modules/command-not-found", from:prezto
    zplug "zsh-users/zsh-autosuggestions", from:github

    ### Emacs
    zplug "plugins/emacs", from:oh-my-zsh

    ### Auto-complete
    zplug "modules/completion", from:prezto
    zplug "racket/shell-completion", from:github, use:racket-completion.zsh
    zplug "fabiokiatkowski/exercism.plugin.zsh", from:github, use:exercism.plugin.zsh
    zplug "plugins/git", from:oh-my-zsh
    zplug "plugins/pip", from:oh-my-zsh
    zplug "plugins/python", from:oh-my-zsh
    zplug "plugins/stack", from:oh-my-zsh
    zplug "plugins/sudo", from:oh-my-zsh

    ### OSX Plugins
    if [[ `uname` == 'Darwin' ]]; then
        zplug "plugins/brew", from:oh-my-zsh, if:"[[ `uname` == 'Darwin' ]]"
        zplug "plugins/osx", from:oh-my-zsh, if:"[[ `uname` == 'Darwin' ]]"
    fi
    ### Syntax Highlighting
    zplug "zdharma/fast-syntax-highlighting", from:github


    # Install plugins if there are plugins that have not been installed
    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi

    # Source plugins and add commands to $PATH
    zplug load
fi

##################
### Theme Options
##
# Currently using "spaceship-prompt" theme
# https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md
export SPACESHIP_PROMPT_ADD_NEWLINE="false"

zstyle ':completion:*' menu select

#######################
### Mac-specific helpers
##
if [[ `uname` == 'Darwin' ]]; then
    # mac path
    eval `/usr/libexec/path_helper -s`
    export PATH=/Library/TeX/texbin:$PATH

    # homebrew tricks
    if brew command command-not-found-init > /dev/null 2>&1; then
        eval "$(brew command-not-found-init)";
    fi

    # mac aliases
    alias rstudio='open -a rstudio'
    alias finder='open -a Finder'
fi

#########################
### Mess with our $PATH
##
# Add Cargo's home path for Rust
export PATH=$HOME/.cargo/bin:$PATH

# Add Haskell Stack's global install bin
export PATH=$HOME/.local/bin:$PATH

# Add Fastlane for iOS and Android CI
export PATH="$HOME/.fastlane/bin:$PATH"

# Anaconda Python path
if [ -n "$ANACONDA_ROOT" ]; then
    export PATH=$ANACONDA_ROOT:$PATH
fi
