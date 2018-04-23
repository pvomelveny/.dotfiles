#!/bin/zsh

# Fancy zsh glob expansions
setopt EXTENDED_GLOB

##################################
## $HOME/.config directory dots ##
##################################
if [ ! -d ".config" ]; then
    mkdir .config
fi

# nvim files and directories
if [ ! -d ".config/nvim" ]; then
    mkdir .config/nvim
fi
# Don't copy the plugged file. should be installed via manager
cp -r ~/.config/nvim/(*~"plugged") ./.config/nvim/

# other .config files
cp -r ~/.config/htop ./.config/

###########################
## $HOME directory files ##
###########################
if [ ! -d ".emacs.d" ]; then
    mkdir .emacs.d
fi

cp -r ~/.zshrc ./
cp -r ~/.tmux.conf ./
cp ~/.emacs.d/configuration.org ./.emacs.d/
cp ~/.emacs.d/init.el ./.emacs.d/
cp -r ~/.emacs.d/lisp ./.emacs.d/lisp
cp -r ~/.editorconfig ./
