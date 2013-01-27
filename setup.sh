#!/bin/bash
# this script deploys your dotfiles into your home dir

# don't worry, if a file already exists we won't touch it
# for everything else, a symlink will be created to this project

# yes, this could be a lot more elegant in ruby or python
# it's in bash so the project has less hard dependencies

if [ $# != 0 ] && [ $1 == "update" ]; then
  git pull --rebase
  exit 0
fi

CONFDIR="$HOME/configs"
FILES=`ls -A $CONFDIR|grep -v "\.git$"|grep -v ".gitignore"|grep -v "setup.sh"|grep -v "old_configs"|grep -v "README"`
echo $FILES;

for FILE in $FILES
do
  # START authorized_keys specific stuff
  if [ $FILE == 'authorized_keys' ]; then
    # ensure ssh dir exists
    if [ ! -d "$HOME/.ssh" ]; then
      echo "no ssh dir, creating"
      mkdir "$HOME/.ssh"
    fi
    # symlink exists:
    if [ -L "$HOME/.ssh/authorized_keys" ]; then
      echo "Symlink for authorized_keys already existed, skipping ..."
      continue
    fi
    # we already have a file there
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
    # if we have gotten here then we are good to do things
    echo "Replacing/Adding new authorized key file..."
    cd "$HOME/.ssh"
    rm -i "$HOME/.ssh/authorized_keys"
    ln -s "$HOME/configs/authorized_keys" "$HOME/.ssh/"
    echo "Verifying permissions on .ssh dir"
    chmod 0700 "$HOME/.ssh"
    chmod 0600 "$CONFDIR/authorized_keys"
    continue
  fi
  # END authorized_keys specific stuff

  # if the symlink exists, don't worry anymore
  if [ -L "$HOME/$FILE" ]; then
    continue
  fi

  # if the file exists...
  if [ -f "$HOME/$FILE" ];
  then
    if [ `diff "$CONFDIR/$FILE" "$HOME/$FILE"|head -n1` ];
    then
      # file already exists its up to you to fix it
      echo -e "The file $FILE already exists, here is the difference:"
      diff "$CONFDIR/$FILE" "$HOME/$FILE"
      echo ""
      continue
    else
      echo -e "The file $FILE already exists but I didn't see any differences so I went ahead and replaced it with a symlink"
      rm "$HOME/$FILE"
      ln -s "$CONFDIR/$FILE" "$HOME/$FILE"
      continue
    fi
  else
    echo -e "The file didn't exist so I'm adding $FILE"
    ln -s "$CONFDIR/$FILE" "$HOME/$FILE"
  fi

done
