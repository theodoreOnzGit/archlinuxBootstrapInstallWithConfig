#!/bin/bash

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot

installAndConfigOpenssh() {
	pacInstall openssh
	sudo systemctl start sshd
	sudo systemctl enable sshd
}


echo "installAndConfigOpenssh --> installs openssh, enables and starts it"

function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

