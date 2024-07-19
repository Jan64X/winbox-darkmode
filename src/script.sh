#!/bin/bash
print "THIS SCRIPT NEEDS TO BE RUN AS YOUR USER AND **NOT** ROOT"
print "A SUDO PRINT COMMAND WILL BE RUN AT THE START WHICH YOU NEED TO CONFIRM"
print "Please confirm the next sudo ask."
sudo print "sudo command OK"
mkdir src
cd src
git clone https://aur.archlinux.org/winbox.git winbox
cd winbox
sudo cp ./winbox /usr/bin/
sudo chmod +x /usr/bin/winbox
wget https://download.mikrotik.com/routeros/winbox/3.40/winbox64.exe
mv winbox64.exe winbox.exe
sudo mkdir /usr/share/winbox
sudo cp ./winbox.exe /usr/share/winbox/winbox.exe
sudo cp winbox.png /usr/share/pixmaps/
sudo cp winbox.desktop /usr/share/applications/
sudo chmod +x /usr/share/applications/winbox.desktop

## dont forget to change to my repo and add the dark mode file thats in my home/winbox_dark/
## do this at the end of the script to make the winbox icon appear
update-desktop-database -q
xdg-icon-resource forceupdate

## reg edit ahead
WINEPREFIX=$HOME/.winbox/wine /usr/bin/wine regedit winbox-darkmode.reg
