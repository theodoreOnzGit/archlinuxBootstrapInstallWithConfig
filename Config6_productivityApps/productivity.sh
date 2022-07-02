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

function whatsappInstall {
	paruInstall franz
}
echo "whatsappInstall --> installs franz, to help have whatsapp"

function zoomInstall {
	paruInstall zoom
}
echo "zoomInstall --> installs zoom from AUR"

function libreOfficeInstall {
	pacInstall libreoffice-fresh
}
echo "libreOfficeInstall --> installs libreoffice using pacman"

function vmwareHorizonInstall() {
	paruInstall vmware-horizon-client
}

echo "vmwareHorizonInstall --> installs vmware horizon client from AUR"

function mendeleyInstall() {
	flatpak install mendeley
}

echo "mendeleyInstall --> installs mendeley"

function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

function paruInstall {
	paru -S $@ --needed --noconfirm
}
echo "paruInstall [packages] --> executes paru -S --needed --noconfirm"
