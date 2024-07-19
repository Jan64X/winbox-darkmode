#!/bin/bash
echo "THIS SCRIPT NEEDS TO BE RUN AS YOUR USER AND **NOT** ROOT"
echo "A SUDO PRINT COMMAND WILL BE RUN AT THE START WHICH YOU NEED TO CONFIRM"
echo "MAKE SURE TO HAVE AN ACTIVE AND STABLE INTERNET CONNECTION"
echo "make SURE that you have wine installed"
sleep 15
echo "Please confirm the next sudo ask."
sudo echo "sudo command OK"
mkdir src-winbox
cd src-winbox
git clone https://github.com/Jan64X/winbox-darkmode.git winbox
cd winbox
cd src
sudo cp ./winbox /usr/bin/
sudo chmod +x /usr/bin/winbox
wget https://download.mikrotik.com/routeros/winbox/3.40/winbox64.exe
mv winbox64.exe winbox.exe
sudo mkdir /usr/share/winbox
sudo cp ./winbox.exe /usr/share/winbox/winbox.exe
sudo cp winbox.png /usr/share/pixmaps/
sudo cp winbox.desktop /usr/share/applications/
sudo chmod +x /usr/share/applications/winbox.desktop
# update the desktop icons, since we just changed them
update-desktop-database -q
xdg-icon-resource forceupdate
# no clue if this is needed for the root user so why not do it here too
sudo update-desktop-database -q
sudo xdg-icon-resource forceupdate
# reg edit ahead
WINEPREFIX=$HOME/.winbox/wine /usr/bin/wine regedit winbox-darkmode.reg
# script done hopefully
echo "check if anything errored out and if not then you should have a nice winbox with dark mode :D"
