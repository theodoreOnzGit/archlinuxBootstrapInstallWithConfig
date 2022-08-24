#!/bin/bash

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot

installAndConfigOpensshServer() {
	pacInstall openssh
	sudo systemctl start sshd
	sudo systemctl enable sshd
	sudo su --command "cp sshd_config /etc/ssh/sshd_config"
}


echo "installAndConfigOpensshServer --> installs openssh, enables and starts it"
echo "also denies root login for sshd"

installAndConfigOpensshClient(){
	pacInstall openssh
}

echo "installAndConfigOpensshClient --> installs openssh"
echo "to connect, use ssh username@ipaddress and follow instructions"

function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

