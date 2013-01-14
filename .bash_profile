# ~/.bash_profile

# get the aliases and functions from .bashrc
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# user-specific environment and startup programs

# include root utils in PATH
export PATH=$PATH:$HOME/bin:/sbin:/usr/sbin

# If we have keychain then we rock
if [ "$(which keychain 2>/dev/null)" ]; then
	eval `keychain --ignore-missing -q --eval ~/.ssh/id_rsa ~/.ssh/id_dsa`
fi

#if [ "$DISPLAY" ]; then
#	if [ "$(which tpb 2>/dev/null)" ]; then
#		tpb -d &
#	fi
#	#set defaluts for x crap
#	if [ `uname` != 'Darwin' ]; then
#		xrdb -load ~/.Xresources
#	fi
#fi

if [ `uname` == 'Darwin' ]; then
	# Adding an appropriate PATH variable for use with MacPorts.
	export PATH=/Users/mcclurem/local/bin:/Users/mcclurem/.gem/ruby/1.8/bin:/opt/local/bin:/opt/local/sbin:/Users/mcclurem/local/avr/bin:$PATH
	# Adding an appropriate MANPATH variable for use with MacPorts.
	export MANPATH=/opt/local/share/man:$MANPATH
fi
