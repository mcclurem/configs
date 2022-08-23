#~/.bash_profile

PrependPath(){
    if [ $# == 1 ];then
        if [[ `echo $PATH|grep $1:` ]]; then
            export PATH=`echo $PATH|sed -e "s|:$1||"`
        fi
        if [ -d $1 ] || [ -f $1 ]; then
           export PATH="$1:$PATH"
        fi
    else
        [[ $(echo "${!1}"|grep "$2:") ]] && return
        if [ -d $2 ] || [ -f $2 ]; then
            if [ "${!1}" != "" ]; then
                export "$1"="$2:${!1}"
            else
                export "$1"="$2"
    fi  fi  fi  
}

AppendPath(){
    if [ $# == 1 ];then
        [[ `echo "$PATH"|grep :$1` ]] && return
        if [ -d $1 ] || [ -f $1 ]; then
            export PATH="$PATH:$1"
        fi
    else 
        [[ $(echo "${!1}"|grep ":$2") ]] && return
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

ssh-add --apple-load-keychain

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
PrependPath "/usr/local/bin"
PrependPath "/usr/local/sbin"
AppendPath "/sbin"
AppendPath "/bin"
AppendPath "/usr/sbin"
AppendPath "/usr/bin"

AppendPath "$HOME/altera/13.0/quartus/bin"

AppendPath "/usr/NX/bin"

#Mac specific path settings
if [ `uname` == 'Darwin' ]; then
    echo "DARWIN"
    # Manpath for gnuutils
    PrependPath MANPATH "/opt/homebrew/opt/coreutils/libexec/gnuman"
    #GNU utils are good
    PrependPath "/opt/local/libexec/gnubin"
    PrependPath "/opt/homebrew/bin"
    PrependPath "/opt/homebrew/opt/coreutils/libexec/gnubin"
fi


# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export P4PORT="ssl:smtp4.ecs.apple.com:1661"
export P4USER="mmcclure"

case $HOSTNAME in
    *ecs* )
        export CALYPSO_CONCEPT_LOG_ENABLE=1
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
        export PATHTO_PERL="/tools/freeware/perl/perl-5.12.1/build/Linux_2.6EL_x86_64/bin/perl"
        export VERSION_PERL="perl-5.12.1"
        export P4PORT="ssl:smtp4.ecs.apple.com:1661"
        export P4TRUST="/org/ees/tools/local/etc/p4trust"
        # RT #35097
        export CDS_LIB="$TOOLSROOT/local/`whichver CDS_LIB_VER`"
        ;;
esac

if [ -f ~/.bash_color_settings ]; then
    source ~/.bash_color_settings
fi

if [ -f ~/.bash_profile_local ]; then
    source ~/.bash_profile_local
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
