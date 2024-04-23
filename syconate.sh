# This is the script which executes according to the fig it is fed. Edit a fig or create a new fig to modify how this script runs.

echo "This is a script that executes according to the fig it is fed."

# Pre-scans for any figs
echo "Scanning for figs..."
find . -type f -name "*.fig" | declare default_fig # -maxdepth 1
echo "$default_fig"
if [[ ! -z $default_fig ]]; then
  echo "Fig found!"
fi

# Prompts the user for a fig
declare current_fig = $(read -p "Which fig do you wish to use? Press enter to use $default_fig or type in a different fig name like so: example.fig")

# Checks user input
if [[ -z $current_fig ]]; then
  # If no current exists, check if default is valid file
  if [[ ! -f $default_fig ]]; then
    echo "No fig entered and no default fig found. Restart the script and either specify a fig or put a .fig file in the same directory"
    exit 1
  # If default exists, use it as current
  fi
  echo "Using $default_fig."
  $current_fig = $default_fig
elif [[ ! -f $current_fig ]]; then  # If no default and current is garbage
  echo "No fig selected. Restart the script and input a fig."
  exit 1
else                                # If no default and current is not garbage, use current
  echo "Using $current_fig."
