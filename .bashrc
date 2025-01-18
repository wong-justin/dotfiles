# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '
# https://unix.stackexchange.com/a/26860
PROMPT_COMMAND='PS1X=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf -- "${q:1}")'
PS1='${PS1X}> '

# taken from: https://stackoverflow.com/a/19533853
# store more command history
# default of 500 is way too little
export HISTFILESIZE=
export HISTSIZE=
# and some sessions will truncate bash history anyways, so use different file
export HISTFILE=~/.bash_eternal_history

# set useful env vars for a variety of tools
export EDITOR=nvim

# TODO: clean up bash history by ignoring commands like `ls` 
# by adding it to the HISTIGNORE env var

# TODO: set vi keybinds instead of emacs things like C-w

# load my aliases
source ~/.bash_aliases

