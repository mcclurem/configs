#~/.bash_profile

PrependPath(){
    if [ $# == 1 ];then
        if [[ `echo $PATH|grep $1` ]]; then
            export PATH=`echo $PATH|sed -e "s|:$1||"`
        fi
        if [ -d $1 ] || [ -f $1 ]; then
           export PATH="$1:$PATH"
        fi
    else
        [[ $(echo "${!1}"|grep "$2") ]] && return
        if [ -d $2 ] || [ -f $2 ]; then
            if [ "${!1}" != "" ]; then
                export "$1"="$2:${!1}"
            else
                export "$1"="$2"
    fi  fi  fi  
}

AppendPath(){
    if [ $# == 1 ];then
        [[ `echo "$PATH"|grep $1` ]] && return
        if [ -d $1 ] || [ -f $1 ]; then
            export PATH="$PATH:$1"
        fi
    else 
        [[ $(echo "${!1}"|grep "$2") ]] && return
        if [ -d $2 ] || [ -f $2 ]; then
            if [ "${!1}" != "" ]; then
                export "$1"="${!1}:$2"
            else
                export "$1"="$2"
    fi  fi  fi  
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
AppendPath "/sbin"
AppendPath "/usr/sbin"

#Arm Development stuff
AppendPath "$HOME/local/yagarto/yagarto-4.6.0/bin"
AppendPath "$HOME/local/yagarto/yagarto-4.6.0/tools"
AppendPath "$HOME/local/src/ct/bin"
#Linux Arm dev stuff
AppendPath "$HOME/local/arm/bin"

#Mac specific path settings
if [ `uname` == 'Darwin' ]; then
    echo "DARWIN"
    #Macports stuff
	# Adding an appropriate PATH variable for use with MacPorts.
	PrependPath "/Users/mcclurem/.gem/ruby/1.8/bin"
    PrependPath "/opt/local/sbin"
    PrependPath "/opt/local/bin"
    AppendPath "/Users/mcclurem/local/avr/bin"
	# Adding an appropriate MANPATH variable for use with MacPorts.
	PrependPath MANPATH "/opt/local/share/man"
    #Macports installs mysql to a dumb location
    AppendPath "/opt/local/lib/mysql5/bin"
    AppendPath "/opt/local/lib/mysql55/bin"
    # Manpath for gnuutils
    PrependPath MANPATH "/opt/homebrew/opt/coreutils/libexec/gnuman"
    #GNU utils are good
    PrependPath "/opt/local/libexec/gnubin/"
    PrependPath "/opt/local/libexec/gnubin/"
    PrependPath "/opt/homebrew/bin"
    PrependPath "/opt/homebrew/opt/coreutils/libexec/gnubin"
    PrependPath "/opt/homebrew/share/python"
    # Now edit the pythonpath
    #Path for MacPorts
	AppendPath PYTHONPATH "/opt/local/lib/python/site-packages"
    AppendPath PYTHONPATH "/opt/local/Library/Frameworks/Python.framework/Versions/2.6/lib/python2.6/site-packages"
    AppendPath PYTHONPATH "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages"
    #Path for homebrew
    AppendPath PYTHONPATH "/opt/homebrew/lib/python2.7/site-packages"
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

case $HOSTNAME in
    *ees-lin* )
        export TOOLSROOT="/tools"
        export VERSION_OSVER="v1.44"
        export CDSPROGS="$TOOLSROOT/vendor/cadencepe/cds_user_progs"
        # unset CDS_OPTOUT to deal with cadence tools being in bin and bin2 - per RT#38456 - 20060831 -- jcw
        unset CDS_OPTOUT
        # Old (pre Sep 2002) wrapper stuff
        export TOOLMAP_ENTRY="/"
        export TOOLMAP_DEFAULT_DIR="$TOOLSROOT/etc"
        export TOOLMAP_VERSIONS=".:"$HOME":$TOOLMAP_DEFAULT_DIR"
        export TOOLMAP_BIN="$TOOLSROOT/release"
        # added temporarily until wrapper is created for ads 28mar01 -- jcw
        export ADS="$TOOLSROOT/vendor/ads"
        export PATH="/tools/freeware/bin:/tools/local/bin:/tools/local/scripts/bin:/tools/vendor/bin:/usr/X11R6/bin:/tools/local/exe:/tools/vendor/exe:/tools/vendor/cadencepe/cds_user_progs:/usr/ucb:$PATH"
        export VENDORTOOLSROOT="$TOOLSROOT/vendor"
        export P4PORT="smtp4.apple.com:1661"
        export PATHTO_PERL="/tools/freeware/perl/perl-5.12.1/build/Linux_2.6EL_x86_64/bin/perl"
        export VERSION_PERL="perl-5.12.1"
        # RT #35097
        export CDS_LIB="$TOOLSROOT/local/`whichver CDS_LIB_VER`"
        ;;
esac

