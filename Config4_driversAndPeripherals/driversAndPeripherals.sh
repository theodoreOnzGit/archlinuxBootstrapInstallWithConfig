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

function nvidiaInstallOpen {
	pacInstall  nvidia-open nvidia-open-dkms \
		nvidia-settings nvidia-utils \
		lib32-nvidia-utils
}

echo "nvidiaInstallOpen --> installs nvidia open source drivers (NOT nouveau)"
echo "Note: I used this on RTX-2060M cards"


function nvidiaInstallClosed {
	pacInstall  nvidia nvidia-lts \
		nvidia-settings nvidia-utils \
		lib32-nvidia-utils
}

echo "nvidiaInstallClosed --> installs nvidia closed source drivers"


function amdInstallOpen {
	pacInstall mesa lib32-mesa \
		vulkan-radeon \
		lib32-vulkan-radeon 
}

echo "amdInstallOpen --> installs AMD drivers and vulkan"
echo "Note: I used this on AMD Raedon Vega Series card "

printerCupsInstall() {
	pacInstall cups bluez-cups
	sudo systemctl start cups
	sudo systemctl enable cups
}

echo "printerCupsInstall --> installs cups for printing"

printerCupsRun() {
	firefox http://localhost:631
}

echo "printerCupsRun --> runs cups in firefox"


gpuTerminalInstall() {
	pacInstall alacritty kitty
}

echo "gpuTerminalInstall --> installs gpu accelerated terminals"


function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

