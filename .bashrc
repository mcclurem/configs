# ~/.bashrc

# test for an interactive shell
if [[ $- != *i* ]]; then
   return
fi

# source global definitions
if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

# history crap
export HISTCONTROL=ignoreboth # ignores dups and whitespace
export HISTIGNORE=clear:ls
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT="%F %T " # show times next to history items
shopt -s histappend

# fix spelling errors
shopt -s cdspell

# tries to save multi line commands as one line
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set vim as the default editor
export EDITOR=`which vim`

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

# sensitive or host-specific data goes in here
if [ -f ~/.bash_profile.private ]; then
  source ~/.bash_profile.private
fi

# load git-prompt if available, else use .bash_prompt
if [ -f ~/other_projects/git-prompt/git-prompt.sh ]; then
  # mkdir -p ~/other_projects
  # git clone https://github.com/dmerrick/git-prompt.git ~/other_projects/git-prompt
  . ~/other_projects/git-prompt/git-prompt.sh
elif [ -f ~/.bash_prompt ]; then
  . ~/.bash_prompt
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

# enable git completion
#NOTE: does not currently work with g() shortcut
if [ -f $HOME/.git-completion.bash ]; then
  source $HOME/.git-completion.bash
fi

# enable ssh completion
function _ssh_completion() {
  perl -ne 'print "$1 " if /^[Hh]ost (.+)$/' ~/.ssh/config
}
complete -W "$(_ssh_completion)" ssh

# enable tab complete for sudo
complete -cf sudo

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
