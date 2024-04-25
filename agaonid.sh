#!/bin/#!/usr/bin/env bash
# This script allows a user to create new custom figs via basic cli menu

echo -e "This script provides the utilty to create a custom fig. A fig is a
  portable configuration file to be used with syconate.sh to quickly and easily
  apply common settings across multiple computers. I hope you enjoy using it!
  -- Chad Peterson"

# Begin menu operations
read -p "Do you wish to create a custom fig? y/n " user_in
if [[ ! $user_in == "y" ]]; then
  exit
fi

# Ask user for custom fig name
read -p "Enter a name for your file in .fig format (eg example.fig): " user_in
if [[ -n $user_in ]]; then
  while [[  ! $user_in =~ \.fig$ ]]; do # Catch files not in .fig format
    echo "Incorrect format. Enter again in format example.fig"
    read -p "Enter a name for your file in .fig format (eg example.fig): " user_in
  done

  # Create new fig file, keeping name as a variable
  touch $user_in
  fig_name=$user_in
  echo "New fig created under name $fig_name"
fi

# Declare user menu because it will be used a lot
user_menu="Select one at a time from the following operations and that operation
  will be added to the custom fig file. Press q at any time to quit.\n\n
  1. Create hidden folder\n
  2. Add new user\n
  3. Create disk partition\n
  4. Set time zone\n
  5. Add git user\n
  6. Clone a github repository\n
  7. Add printer in CUPS\n
  8. Copy folders from USB\n
  9. Create cron schedule for log file compression\n"
echo -e $user_menu # Display user menu
read -p "Enter selection: " user_in # Request input
source wasp.nest # Import master config file wasp.nest as source

# Until user quits, add specified config settings
while [[ ! $user_in == "q" ]]; do
  if [[ $user_in == 1 ]]; then
    echo -e $make_hidden_directory >> $fig_name
    echo "Added operation create hidden folder to $fig_name"
  fi
  if [[ $user_in == 2 ]]; then
    echo -e $user_add >> $fig_name
    echo "Added operation add new user to $fig_name"
  fi
  if [[ $user_in == 3 ]]; then
    echo -e $part_disk >> $fig_name
    echo "Added operation create disk partition folder to $fig_name"
  fi
  if [[ $user_in == 4 ]]; then
    echo -e $timezone_change >> $fig_name
    echo "Added operation set time zone to $fig_name"
  fi
  if [[ $user_in == 5 ]]; then
    echo -e $add_gituser >> $fig_name
    echo "Added operation add git user to $fig_name"
  fi
  if [[ $user_in == 6 ]]; then
    echo -e $clone_repo >> $fig_name
    echo "Added operation clone a github repository to $fig_name"
  fi
  if [[ $user_in == 7 ]]; then
    echo -e $add_printer >> $fig_name
    echo "Added operation add printer in CUPS to $fig_name"
  fi
  if [[ $user_in == 8 ]]; then
    echo -e $copy_usb >> $fig_name
    echo "Added operation copy folders from USB to $fig_name"
  fi
  if [[ $user_in == 9 ]]; then
    echo -e $add_compress_schedule >> $fig_name
    echo "Added operation create cron schedule for log file compression to $fig_name"
  fi
  echo -e $user_menu # Display user menu
  read -p "Enter selection: " user_in # Request input
done
echo -e "Operation complete. $fig_name created.\nTo use $fig_name, place it and syconate.sh in the same folder and execute syconate.sh."