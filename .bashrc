# .bashrc

# user-specific aliases and functions

# test for an interactive shell
if [[ $- != *i* ]]; then
   return
fi

# history crap
export HISTCONTROL=ignoredups
export HISTIGNORE=clear:ls

# set vim as the default editor
export EDITOR=`which vim`

# source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

# source aliases
if [ -f ~/.aliases ]; then
	source ~/.aliases
fi

# source prompt
if [ -f ~/.bash_prompt ]; then
	source ~/.bash_prompt
   else
	PS1='$PWD > '
fi

# source bash completion
if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

if [ -f /opt/local/etc/bash_completion ]; then
	source /opt/local/etc/bash_completion
fi

if [ -f /etc/profile.d/bash-completion.sh ]; then
	source /etc/profile.d/bash-completion.sh
fi

# set up simple .plan (for finger utility)
if [ `uname` != 'Darwin' ]; then
	echo -e "$(uname -a)"> ~/.plan
fi

# grep color options
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
