# .bashrc

# User specific aliases and functions

# Defines the verbose variable, see .bashprompt.sh for details
VERB=0
export VERB

# test for an interactive shell.
if [[ $- != *i* ]]; then
   return
fi

# History crap
HISTCONTROL=ignoredups
HISTIGNORE=clear:ls
export HISTCONTROL
export HISTIGNORE


# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

# Source aliases
if [ -f ~/.aliases ]; then
	source ~/.aliases
fi

# Source prompt
if [ -f ~/.bash_prompt ]; then
	source ~/.bash_prompt
   else
	PS1='$PWD > '
fi
# Bash Completion
if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

if [ -f /etc/profile.d/bash-completion.sh ]; then
	source /etc/profile.d/bash-completion.sh
fi

# .plan (for finger)
echo -e "Home Phone:    978-448-6288\nCell Phone:    978-400-6980\n-----\n`uname -o` `uname -rp`\n`uname -n`"> ~/.plan

# Grep color options
  export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
