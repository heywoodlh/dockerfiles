#!/usr/bin/env bash
set -ex

if [[ -n "$GNOME_KEYRING_PASSWORD" ]]
then
  echo "$GNOME_KEYRING_PASSWORD" | gnome-keyring-daemon -r --daemonize --unlock -c secrets
  # Check if default keyring exists
  if [[ -e $HOME/.local/share/keyrings/Default_keyring.keyring ]]
  then
    echo "Keyring exists"
    exit 0
  else
    echo "Keyring does not exist, creating"
    mkdir -p "$HOME/.local/share/keyrings"
    printf "[keyring]\n\display-name=Login\n\
      ctime=1614975180\n\
      mtime=0\n\
      lock-on-idle=false\n\
      lock-after=false\n" > "$HOME/.local/share/keyrings/Login.keyring"
    printf "login" > "$HOME/.local/share/keyrings/default"
    echo "$GNOME_KEYRING_PASSWORD" | gnome-keyring-daemon -r --daemonize --unlock -c secrets
    exit 0
  fi
else
  # Don't make any assumptions about the gnome-keyring if no passphrase is provided
  gnome-keyring-daemon --daemonize --unlock -c secrets
  exit 0
fi
