#!/bin/bash



if [ $# != 0 ] && [ $1 == "update" ]; then
		svn update
		exit 0
fi

CONFDIR="$HOME/configs"
FILES=`ls -A $CONFDIR|grep -v "\.svn"|grep -v "setup.sh"`
echo $FILES;
for FILE in $FILES
do
	if [ $FILE == 'authorized_keys' ]; then
		if [ -f "$HOME/.ssh/authorized_keys" ] && [ `diff "$HOME/.ssh/authorized_keys" "$CONFDIR/authorized_keys"` ];
		then
			echo -e "The file $FILE already exists, here is the difference:"
			diff "$HOME/.ssh/authorized_keys" "$CONFDIR/authorized_keys"
			echo "\n\nDo you want to replace it with the new one?[y/n]"
			read USERINPUT
			if [ "$USERINPUT" == "${USERINPUT#[Yy]}" ]
			then
				echo "Replacing it..."
				mv -i "$CONFDIR/authorized_keys" "$HOME/.ssh/authorized_keys"
				echo "Verifying permissions on .ssh dir"
				chmod 0700 "$HOME/.ssh"
			else
				echo "Not replacing the authorized keys file"
			fi
		else
			echo "Authorized key file seems up to date"
		fi
		continue
	fi

	#if the symlink exists, don't worry anymore
	if [ -L "$HOME/$FILE" ]; then
			continue
	fi

	if [ -f "$HOME/$FILE" ] && [ `diff "$CONFDIR/$FILE" "$HOME/$FILE"|head -n1` ]; then
			#file already exists its up to you to fix it
			echo -e "The file $FILE already exists, here is the difference:"
			diff "$CONFDIR/$FILE" "$HOME/$FILE"
			continue
	fi

	if [ -f "$HOME/$FILE" ]; then
			echo -e "The file $FILE already exists but I didn't see any differences so I went ahead and replaced it with a symlink"
			rm "$HOME/$FILE"
			ln -s "$CONFDIR/$FILE" "$HOME/$FILE"
			continue
	fi

	echo -e "I don't think anything existed so I'm adding $FILE"
	ln -s "$CONFDIR/$FILE" "$HOME/$FILE"

done
