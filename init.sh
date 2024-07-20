#!/bin/bash
echo "start"

# checking if root
# terminate if true
check_root() {
    if [[ $EUID -eq 0 ]]; then
        echo "This script should not be run as root. Terminating."
        exit 1
    fi
}
# call
check_root

# Function to ask the user if they want to continue
ask_continue() {
    read -p "Do you want to continue and have wget,git and wine installed? (y/n): " user_input

    if [[ "$user_input" == "y" || "$user_input" == "Y" ]]; then
        echo "Continuing the script..."
    else
        echo "Terminating the script."
        exit 1
    fi
}

# call
ask_continue

echo "preparing..."
cd ~/Downloads/
git clone https://github.com/Jan64X/winbox-darkmode.git
cd winbox-darkmode
cd src
chmod +x ./script.sh
echo "running script..."
./script.sh
echo "script done, cleaning up..."
cd ../..
rm -rf ./winbox-darkmode
echo "done :D, enjoy"
