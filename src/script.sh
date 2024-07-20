#!/bin/bash
echo "A SUDO PRINT COMMAND WILL BE RUN AT THE START WHICH YOU NEED TO CONFIRM"
sleep 5
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
echo "Please confirm the next sudo ask."
sudo echo "sudo command OK"
echo "copying required files..."
sudo cp ./winbox /usr/bin/
sudo chmod +x /usr/bin/winbox
echo "getting winbox 3.40 from mikrotik.com..."
wget https://download.mikrotik.com/routeros/winbox/3.40/winbox64.exe
mv winbox64.exe winbox.exe
echo "preparing for user launchable .desktop file"
sudo mkdir /usr/share/winbox
sudo cp ./winbox.exe /usr/share/winbox/winbox.exe
sudo cp winbox.png /usr/share/pixmaps/
sudo cp winbox.desktop /usr/share/applications/
sudo chmod +x /usr/share/applications/winbox.desktop
# update the desktop icons, since we just changed them
echo "updating .desktop database..."
echo "if the X thing errors out then don't panic, that's normal"
update-desktop-database -q
xdg-icon-resource forceupdate
# no clue if this is needed for the root user so why not do it here too
sudo update-desktop-database -q
sudo xdg-icon-resource forceupdate
echo " !! THE SCRIPT IS GOING TO OPEN A WINE SETUP WINDOW, "
echo "LET IT RUN AND WINBOX WILL OPEN AND CLOSE AFTER A MOMENT!!"
# run before doing the reg edit to generate a wine config
# pkill script, remove this if automating doesnt work
# Function to run pkill winbox every 2 seconds until it kills a process
pkill_loop() {
    while true; do
        sleep 5
        pkill winbox.exe
        if [[ $? -eq 0 ]]; then
            echo "winbox process killed."
            break
        fi
    done
}

# Start the pkill loop in the background
pkill_loop &
echo "running winbox..."
/usr/bin/winbox
# reg edit ahead
echo "winbox closed gracefully, continuing..."
echo "editing registry to add dark mode .reg file"
WINEPREFIX=$HOME/.winbox/wine /usr/bin/wine regedit winbox-darkmode.reg
# script done hopefully
echo "check if anything errored out and if not then you should have a nice winbox with dark mode :D"
echo "running darkmode winbox"
sleep 5
/usr/bin/winbox &
echo "done!"
