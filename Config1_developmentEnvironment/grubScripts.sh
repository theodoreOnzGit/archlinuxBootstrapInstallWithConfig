#!/bin/bash

function grubAddonsInstall {
	pacInstall grub-customizer \
		breeze-grub \
		hwinfo
}

echo "grubAddonsInstall --> adds grub customizer and breeze-grub themes"
echo " "

function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"
