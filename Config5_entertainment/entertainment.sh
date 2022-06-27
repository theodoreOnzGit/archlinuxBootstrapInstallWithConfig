#!/bin/bash


function steamlib32Install {
	pacInstall lib32-systemd \
		wqy-zenhei \
		ttf-liberation \
		lib32-mesa \
		lib32-nvidia-utils \
		steam
}

echo "steamlib32Install --> installs the 32 bit version"
echo "of steam" 

function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

