# .bashrc

# user-specific aliases and functions

# test for an interactive shell
if [[ $- != *i* ]]; then
   return
fi

# history crap
export HISTCONTROL=ignoreboth # ignores dups and whitespace
export HISTIGNORE=clear:ls
export HISTSIZE=1000000
export HISTFILESIZE=1000000
shopt -s histappend

# fix spelling errors
shopt -s cdspell

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

# source alias.sh aliases
if [ -f ~/.aliases.sh ]; then
  # curl https://alias.sh/user/296/alias >> ~/.aliases.sh
  source ~/.aliases.sh
  #source <(wget -q -O - "$@" https://alias.sh/user/296/alias)
fi

# source prompt
if [ -f $HOME/other_projects/git-prompt/git-prompt.sh ]; then
  # load git-prompt if available
  . $HOME/other_projects/git-prompt/git-prompt.sh
elif [ -f ~/.bash_prompt ]; then
  . $HOME/.bash_prompt
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

# from pancake .bashrc
# enables ^s and ^q in rTorrent, when running in screen
stty -ixon -ixoff