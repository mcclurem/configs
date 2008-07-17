# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin:/sbin:/usr/sbin

export PATH
unset USERNAME

# If we have keychain then we rock
if [ "$(which keychain 2>/dev/null)" ]; then
	eval `keychain --ignore-missing -q --eval ~/.ssh/id_rsa ~/.ssh/id_dsa`
fi

if [ "$DISPLAY" ]; then
	
	if [ "$(which tpb 2>/dev/null)" ]; then
		tpb -d &
	fi
	#set defaluts for x crap
	xrdb -load ~/.Xresources
fi


