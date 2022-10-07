#!/bin/bash


# this file is meant to be sourced, and then you have many functions with
# which to install arch

# for this file, you will be executing commands in the 
# chroot environment

# the chrootExec function
# executes a command in the chroot environment
# assuming the chroot is at /mnt
# credit to:
# https://askubuntu.com/questions/551195/scripting-chroot-how-to

echo "NOTE: scripts are meant to be run from bootstrap, NOT chrooted"
echo "in your installation!"

echo " "
echo " "
function chrootExec {
	touch chrootExec.sh
	chmod 755 chrootExec.sh
	echo $1 >> chrootExec.sh
	rm -rf /mnt/root/chrootExec.sh
	mv chrootExec.sh /mnt/root/chrootExec.sh
	arch-chroot /mnt /root/chrootExec.sh
	rm -rf /mnt/root/chrootExec.sh
}

echo "chrootExec [COMMAND] --> execute command from chroot"

function InstallDrivers {

	pacstrapInstall -Ss xf86-video
	pacstrapInstall xorg-drivers


}

echo "InstallDrivers --> displays and installs xorg-drivers"

function InstallXorg {
	pacstrapInstall xorg xorg-apps

}
echo "InstallXorg --> installs xorg-apps and xorg to /mnt"

function InstallKDE {
	InstallDrivers
	InstallXorg
	pacstrapInstall plasma-meta kde-applications
	pacstrapInstall sddm sddm-kcm
	chrootExec "systemctl enable sddm"
}

echo "InstallKDE --> installs KDE-plasma and enables sddm service in systemctl"

function InstallCinnamon {
	InstallDrivers
	InstallXorg
	pacstrapInstall cinnamon firefox 
	pacstrapInstall sddm sddm-kcm
	chrootExec "systemctl enable sddm"

}

echo "InstallCinnamon --> installs cinnamon and enables sddm service in systemctl"



function pacstrapInstall {

	pacstrap /mnt $@ --needed --noconfirm
}
