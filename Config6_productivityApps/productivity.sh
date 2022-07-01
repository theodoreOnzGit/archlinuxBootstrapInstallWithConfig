#!/bin/bash

function obsStudioInstall {

	pacInstall obs-studio
	paruInstall obs-ndi
	pacInstall ffnvcodec-headers \
		libva-intel-driver \
		libva-mesa-driver
}

echo "obsStudioInstall --> installs obs-studio and some other"
echo "useful packages for obs"

function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

function paruInstall {
	paru -S $@ --needed --noconfirm
}
echo "paruInstall [packages] --> executes paru -S --needed --noconfirm"
