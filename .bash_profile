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
	if [ `uname` != 'Darwin' ]; then
		xrdb -load ~/.Xresources
	fi
fi

if [ `uname` == 'Darwin' ]; then
	# Adding an appropriate PATH variable for use with MacPorts.
	export PATH=/Users/mcclurem/.gem/ruby/1.8/bin:/opt/local/bin:/opt/local/sbin:$PATH
	# Adding an appropriate MANPATH variable for use with MacPorts.
	export MANPATH=/opt/local/share/man:$MANPATH
	# Now edit the pythonpath
	export PYTHONPATH=/opt/local/lib/python/site-packages:/opt/local/Library/Frameworks/Python.framework/Versions/2.6/lib/python2.6/site-packages/
fi

##
# Your previous /Users/mcclurem/.bash_profile file was backed up as /Users/mcclurem/.bash_profile.macports-saved_2010-01-24_at_12:30:21
##

# MacPorts Installer addition on 2010-01-24_at_12:30:21: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


##
# Your previous /Users/mcclurem/.bash_profile file was backed up as /Users/mcclurem/.bash_profile.macports-saved_2010-04-22_at_15:19:13
##

# MacPorts Installer addition on 2010-04-22_at_15:19:13: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

