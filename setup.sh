#!/bin/bash



if [ $# != 0 ] && [ $1 == "update" ]; then
		svn update
		exit 0
fi

CONFFOLD="configs"
CONFDIR="$HOME/$CONFFOLD"
FILES=`ls -A $CONFDIR|grep -v "\.svn"|grep -v "setup.sh"`
echo $FILES;
for FILE in $FILES
do
#Specific stuff for the auth key file:
	if [ $FILE == 'authorized_keys' ]; then
		#We already have a file there
		if [ -f "$HOME/.ssh/authorized_keys" ];
		then
			#If there are differences:
			if [ `diff "$HOME/.ssh/authorized_keys" "$CONFDIR/authorized_keys"|head -n1` ];
			then
				echo -e "The file $FILE already exists, here is the difference:"
				diff "$HOME/.ssh/authorized_keys" "$CONFDIR/authorized_keys"
				echo "\n\nDo you want to replace it with the new one?[y/n]"
				read USERINPUT
				#Its a bit confusing, but this says, if 'y' then do
				if [ "$USERINPUT" != "${USERINPUT#[Yy]}" ]
				then
					echo "Replacing it..."
					rm -i "$HOME/.ssh/authorized_keys"
					cd "$HOME/.ssh"
					ln -s "../$CONFDIR/authorized_keys" "$HOME/.ssh/authorized_keys"
					echo "Verifying permissions on .ssh dir"
					chmod 0700 "$HOME/.ssh"
					chmod 0700 "$CONFDIR/authorized_keys"
				else
					echo "Not replacing the authorized keys file"
				fi
			else
				echo "Authorized key file seems up to date"
			fi
		else
			echo "Adding new authorized key file..."
			cd "$HOME/.ssh"
			ln -s "../$CONFDIR/authorized_keys" "$HOME/.ssh/authorized_keys"
			echo "Verifying permissions on .ssh dir"
			chmod 0700 "$HOME/.ssh"
			chmod 0700 "$CONFDIR/authorized_keys"
		fi
		continue
	fi

	#if the symlink exists, don't worry anymore
	if [ -L "$HOME/$FILE" ]; then
			continue
	fi
#If the file exists...
	if [ -f "$HOME/$FILE" ];
	then
		if [ `diff "$CONFDIR/$FILE" "$HOME/$FILE"|head -n1` ];
		then
			#file already exists its up to you to fix it
			echo -e "The file $FILE already exists, here is the difference:"
			diff "$CONFDIR/$FILE" "$HOME/$FILE"
			continue
		else
			echo -e "The file $FILE already exists but I didn't see any differences so I went ahead and replaced it with a symlink"
			rm "$HOME/$FILE"
			ln -s "$CONFDIR/$FILE" "$HOME/$FILE"
			continue
		fi
	else
		echo -e "I don't think anything existed so I'm adding $FILE"
		ln -s "$CONFDIR/$FILE" "$HOME/$FILE"
	fi

done
