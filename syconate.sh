#!/bin/#!/usr/bin/env bash

# This is the script which executes according to the fig it is fed. Edit a fig or create a new fig to modify how this script runs.

echo "This is a script that executes according to the fig it is fed."

# Scans for figs in current directory
echo "Scanning for figs..."
mapfile -t scanned_figs < <(find . -type f -name "*.fig")
if [[ -f ${scanned_figs[0]} ]]; then
  echo "Found!"
else
  echo "No figs found, add a fig to the same directory as syconate.sh"
fi

# If more than one fig, tell user it defaults to the first
if [[ $(find . -type f -name "*.fig" | wc -l) -gt 1 ]]; then
  echo "Multiple figs scanned. Defaulting to first fig ${scanned_figs[0]}"
else
  echo "Using ${scanned_figs[0]}"
fi

# Set current fig to be the first scanned
current_fig=${scanned_figs[0]}

#echo "Reached end of file with $current_fig in memory"

# Import current fig for variable usage
#shellcheck source=. #This is only used by shellcheck
source $current_fig

# Creates a user if the current fig asks for it (Module 10)
if [[ $username && $pswd ]]; then
  echo "Adding user $username with dummy password"
  sudo useradd $username
  sudo id $username
  echo "$username:$pswd" | sudo chpasswd
  sudo chage -l $username
fi

# Modifies access control list for a user if the current fig asks for it (Module 4)
if [[ $hideuser && $hidedir ]]; then
  echo "Making a hidden directory $hidedir for $hideuser"
  if [[ $hidedir ]]; then
    rmdir $hidedir
  fi
  mkdir $hidedir
  sudo chown $hideuser $hidedir
  sudo chmod 700 $hidedir
  sudo setfacl -m g::--- $hidedir
  sudo setfacl -m o::--- $hidedir
  sudo setfacl -m u:$hideuser:rwx $hidedir
  getfacl $hidedir
fi

if [[ $newdir ]]; then
  echo "Copying files from USB into new directory $newdir"
  mkdir $newdir
  if [[ ! -d /mnt/usb ]]; then
    mkdir /mnt/usb
  fi
  sudo mount /dev/sdb1 /mnt/usb
  cd /mnt/usb || return
  cp -r * $newdir
  ls $newdir
fi