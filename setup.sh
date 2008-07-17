#!/bin/bash

FILES=`ls -A ./|grep -v "\.svn"`
echo $FILES;
for FILE in $FILES
do
	#if the symlink exists, don't worry anymore
	if [ -L "$HOME/$FILE" ]; then
			continue
	fi

	if [ -f "$HOME/$FILE" ] && [ `diff "$PWD/$FILE" "$HOME/$FILE"` ]; then
			#file already exists its up to you to fix it
			echo -e "The file $FILE already exists, here is the difference:"
			diff "$PWD/$FILE" "$HOME/$FILE"
			continue
	fi

	if [ -f "$HOME/$FILE" ] && ![ `diff "$PWD/$FILE" "$HOME/$FILE"` ]; then
			echo -e "The file $FILE already exists but I didn't see any differences so I went ahead and replaced it with a symlink"
			rm "$HOME/$FILE"
			ln -s "$PWD/$FILE" "$HOME/$FILE"
			continue
	fi

	ln -s "$PWD/$FILE" "$HOME/$FILE"

done
