# ~/.bash_logout
# runs when you log out

# clear our tickets
if we_have sudo; then
 sudo -k 2>/dev/null
fi

# clear the screen
clear
