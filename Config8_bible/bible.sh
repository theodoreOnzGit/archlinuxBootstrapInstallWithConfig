#!/bin/bash

bibleAppsInstall() {
	paruInstall xiphos \
		bibletime
}

echo "bibleAppsInstall --> installs xiphos and bibletime "


function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

function paruInstall {
	paru -S $@ --needed --noconfirm
}
echo "paruInstall [packages] --> executes paru -S --needed --noconfirm"
