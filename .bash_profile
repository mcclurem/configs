#~/.bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

#fink setup
if [ -f /sw/bin/init.sh ]; then
	. /sw/bin/init.sh
fi

# User specific environment and startup programs
export PATH=$PATH:$HOME/bin:/sbin:/usr/sbin

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
	if [ `uname` != 'Darwin' ]; then
		xrdb -load ~/.Xresources
	fi
fi

#Arm Development stuff
if [ -f "$HOME/local/yagarto" ]; then
    export PATH="$PATH:$HOME/local/yagarto/yagarto-4.6.0/bin"
    export PATH="$PATH:$HOME/local/yagarto/yagarto-4.6.0/tools"
    export PATH="$PATH:$HOME/local/src/ct/bin"
fi
#Linux Arm dev stuff
if [ -d "$HOME/local/arm/bin" ]; then
    export PATH="$PATH:$HOME/local/arm/bin"
fi


#GNU coreutils
if [ -d /opt/local/libexec/gnubin ]; then
    export PATH="/opt/local/libexec/gnubin:$PATH"
fi

#Macports stuff
if [ `uname` == 'Darwin' ]; then
	# Adding an appropriate PATH variable for use with MacPorts.
	export PATH=/Users/mcclurem/local/bin:/Users/mcclurem/.gem/ruby/1.8/bin:/opt/local/bin:/opt/local/sbin:/Users/mcclurem/local/avr/bin:$PATH
	# Adding an appropriate MANPATH variable for use with MacPorts.
	export MANPATH=/opt/local/share/man:$MANPATH
	# Now edit the pythonpath
	export PYTHONPATH=/opt/local/lib/python/site-packages:/opt/local/Library/Frameworks/Python.framework/Versions/2.6/lib/python2.6/site-packages/
fi





