#!/bin/bash


function guestUtils() {
	pacInstall virtualbox-guest-utils
}

echo "guestUtils --> installs virtualbox guest utils"




function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

