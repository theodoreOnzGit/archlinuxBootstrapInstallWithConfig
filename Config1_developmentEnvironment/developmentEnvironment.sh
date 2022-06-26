#!/bin/bash

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot
function webBrowsers {
	pacInstall firefox firefox-addons chromium
}

echo "webBroswers --> installs firefox addons and chromium"

function installVimPack {
	pacInstall vim-plugins neovim vim
}

echo "installVimPack --> installs vim addons and neovim"

function pacInstall {
	sudo pacman -S $1 --needed --noconfirm
}

echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

