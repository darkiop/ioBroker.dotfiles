#!/usr/bin/env bash
#
# https://github.com/darkiop/ioBroker.dotfiles

# ${HOME}/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
#[ -z "$PS1" ] && return

# path
#PATH=$PATH:~/dotfiles/bin

# Distribute bashrc into smaller, more specific files
#source ~/dotfiles/shells/defaults
#source ~/dotfiles/shells/functions
#source ~/dotfiles/shells/exports
source ~/iobroker-dotfiles/shells/alias
#source ~/dotfiles/shells/alias-git
#source ~/dotfiles/shells/alias-docker
source ~/iobroker-dotfiles/shells/prompt

# motd
clear
source ~/iobroker-dotfiles/motd/motd.sh

# EOF
