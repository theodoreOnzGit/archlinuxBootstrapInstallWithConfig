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

function whatsappFranzInstall {
	paruInstall franz
}
echo "whatsappFranzInstall --> installs franz, to help have whatsapp"

whatsappNativeFierInstall() {
	paruInstall whatsapp-nativefier
}

echo "whatsappNativeFierInstall --> installs a nativefier version of "
echo "whatsapp  (electron)"
paru -Ss whatsapp-nativefier


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
echo ""

sambaInstall() {
	pacInstall samba
	sudo cp -i ./smb.conf /etc/samba/.
	sudo systemctl enable smb
	sudo systemctl start smb
}


echo "sambaInstall --> installs and enables samba using systemctl"
echo "note: also copies smb.conf in the current folder to the root folder"
echo ""

timerToolsInstall() {
	pacInstall termdown
}

echo "timerToolsInstall --> installs stopwatches, timers etc"
echo ""


function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}




echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

function paruInstall {
	paru -S $@ --needed --noconfirm
}
echo "paruInstall [packages] --> executes paru -S --needed --noconfirm"
