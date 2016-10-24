# ~/.bashrc

# user-specific environment and startup programs

# test for an interactive shell
if [[ $- != *i* ]]; then
  return
fi

# source global definitions
[ -f /etc/bashrc ] && source /etc/bashrc

# include root utils in PATH
export PATH=$PATH:$HOME/bin:/sbin:/usr/sbin

# RVM settings
[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm

# if we have keychain then we rock
if [ "$(which keychain 2>/dev/null)" ]; then
  eval `keychain --ignore-missing -q --eval ~/.ssh/id_rsa ~/.ssh/id_dsa`
fi

# os x stuff here
if [ `uname` == 'Darwin' ]; then
  # Adding an appropriate PATH variable for use with MacPorts.
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  # Adding an appropriate PATH variable for use with Homebrew.
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
  # Adding an appropriate MANPATH variable for use with MacPorts.
  export MANPATH=/opt/local/share/man:$MANPATH

  # custom ls colors
  export CLICOLOR=1
  export LSCOLORS=FxFxCxDxBxegedabagacfH # pretty much only for the last 2 chars

  # needed for SSD drives
  ulimit -n 1024
fi

# history crap
export HISTCONTROL=ignoreboth # ignores dups and whitespace
export HISTIGNORE=clear:ls
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT="%F %T " # show times next to history items
#HISTFILE="${HOME}/.history/$(date -u +%Y/%m/%d.%H.%M.%S)_${HOSTNAME_SHORT}_$$"
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
[ -f ~/.aliases ] && source ~/.aliases

# source alias.sh aliases
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
# curl https://alias.sh/user/296/alias >> ~/.aliases.sh
#source <(wget -q -O - "$@" https://alias.sh/user/296/alias)

# sensitive or host-specific data goes in here
[ -f ~/.bash_profile.private ] && source ~/.bash_profile.private

# load git-prompt if available, else use .bash_prompt
if [ -f ~/other_projects/git-prompt/git-prompt.sh ]; then
  # mkdir -p ~/other_projects
  # git clone https://github.com/dmerrick/git-prompt.git ~/other_projects/git-prompt
  source ~/other_projects/git-prompt/git-prompt.sh
elif [ -f ~/.bash_prompt ]; then
  source ~/.bash_prompt
else
  PS1='$PWD > '
fi

# source bash completion
[ -f /etc/bash_completion ] && source /etc/bash_completion
[ -f /opt/local/etc/bash_completion ] && source /opt/local/etc/bash_completion
[ -f /etc/profile.d/bash-completion.sh ] && source /etc/profile.d/bash-completion.sh
if we_have brew
  then [ -f `brew --prefix`/share/bash-completion/bash_completion ] && source `brew --prefix`/share/bash-completion/bash_completion
fi

# enable git completion
#NOTE: does not currently work with g() shortcut
[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash

# enable ssh completion
if [ -f ~/.ssh/config ]; then
  function _ssh_completion() {
    perl -ne 'print "$1 " if /^[Hh]ost (.+)$/' ~/.ssh/config
  }
  complete -W "$(_ssh_completion)" ssh
fi

# enable tab complete for sudo
complete -cf sudo

# set up simple .plan (for finger utility)
if [ `uname` != 'Darwin' ]; then
  echo -e "$(uname -a)"> ~/.plan
fi

# auto-expand history
bind Space:magic-space

# grep color options
export GREP_COLOR='1;32'

# from pancake .bashrc
# enables ^s and ^q in rTorrent, when running in screen
stty -ixon -ixoff

export PATH=/usr/texbin:"$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
