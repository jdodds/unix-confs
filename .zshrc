# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jdd/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U promptinit && promptinit
autoload -U colors && colors

PROMPT="%{$fg[white]%}%B%n%b %{$reset_color%}%{$fg[green]%}%n%{$reset_color%}:%~
"

alias project="source $HOME/bin/project"
