#~/.bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

#fink setup
if [ -f /sw/bin/init.sh ]; then
	. /sw/bin/init.sh
fi

function PrependPath(){
    if [ -d $0 ] || [ -f $0 ]; then
       export PATH="$0:$PATH"
    fi
}

function AppendPath(){
    if [ -d $0 ] || [ -f $0 ]; then
       export PATH="$PATH:$0"
    fi
}



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

PrependPath "$HOME/bin"
PrependPath "$HOME/local/bin"
AppendPath "/sbin:/usr/sbin"

#Arm Development stuff
AppendPath "$HOME/local/yagarto/yagarto-4.6.0/bin"
AppendPath "$HOME/local/yagarto/yagarto-4.6.0/tools"
AppendPath "$HOME/local/src/ct/bin"
#Linux Arm dev stuff
AppendPath "$HOME/local/arm/bin"



#Macports stuff
if [ `uname` == 'Darwin' ]; then
	# Adding an appropriate PATH variable for use with MacPorts.
	PrependPath "/Users/mcclurem/.gem/ruby/1.8/bin"
    PrependPath "/opt/local/bin:/opt/local/sbin"
    AppendPath "/Users/mcclurem/local/avr/bin"
	# Adding an appropriate MANPATH variable for use with MacPorts.
	export MANPATH=/opt/local/share/man:$MANPATH
	# Now edit the pythonpath
	export PYTHONPATH=/opt/local/lib/python/site-packages:/opt/local/Library/Frameworks/Python.framework/Versions/2.6/lib/python2.6/site-packages/
fi





