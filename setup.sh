#!/usr/bin/env bash


CONFDIR="$HOME/configs"
FILES=`ls -A $CONFDIR | grep -v "setup.sh" | grep -v -e "\.git\b" | grep -v "README" | grep -v "authorized_keys"`
echo $FILES;
for FILE in $FILES
do
    if [ $FILE == 'README.md' ]; then
        continue
    fi
#Specific stuff for the auth key file:
	if [ $FILE == 'authorized_keys' ]; then
        #ensure ssh dir exists
        if [ -d "$HOME/.ssh" ]; then
            echo "ssh dir exists"
        else
            echo "no ssh dir, creating"
            mkdir "$HOME/.ssh"
        fi
		#symlink exists:
		if [ -L "$HOME/.ssh/authorized_keys" ]; then
			echo "Simlink for authorized_keys already existed, skipping ..."
			continue
		fi
		#We already have a file there
		if [ -f "$HOME/.ssh/authorized_keys" ] && [ `diff "$HOME/.ssh/authorized_keys" "$CONFDIR/authorized_keys"|head -n1` ]; then
				echo -e "The file $FILE already exists, here is the difference:"
				diff "$HOME/.ssh/authorized_keys" "$CONFDIR/authorized_keys"
				echo "\n\nDo you want to replace it with the new one?[y/n]"
				read USERINPUT
				#Its a bit confusing, but this says, if NOT 'y' then do
				if [ "$USERINPUT" == "${USERINPUT#[Yy]}" ]; then
					echo "Not replacing the authorized keys file"
					continue
				fi
		fi
		#If we have gotten here then we are good to do things
		echo "Replacing/Adding new authorized key file..."
		cd "$HOME/.ssh"
		rm -i "$HOME/.ssh/authorized_keys"
		ln -s "$HOME/configs/authorized_keys" "$HOME/.ssh/"
		echo "Verifying permissions on .ssh dir"
		chmod 0700 "$HOME/.ssh"
		chmod 0600 "$CONFDIR/authorized_keys"
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
