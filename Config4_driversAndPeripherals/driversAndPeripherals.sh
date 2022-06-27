#!/bin/bash

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot
function keyboardTuxedo {
	pacInstall linux-lts-headers linux-headers
	paru -S tuxedo-control-center-bin
}

echo "keyboardTuxedo --> installs tuxedo control center from AUR"
echo "linux headers and linux lts headers"

function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

