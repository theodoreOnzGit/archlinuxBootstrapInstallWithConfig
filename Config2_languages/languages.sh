#!/bin/bash

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot
function hebrewAdd {
	pacInstall firefox-i18n-he 
	sudo sed -i 's/#he_IL.UTF-8/he_IL.UTF-8/g' /etc/locale.gen
	sudo locale-gen
}

echo "hebrewAdd --> installs firefox hebrew and adds the locale"

function koreanAdd {
	pacInstall firefox-i18n-ko
	sudo sed -i 's/#ko_KR.UTF-8/ko_KR.UTF-8/g' /etc/locale.gen
	sudo locale-gen
}

echo "koreanAdd --> installs firefox korean and adds the locale"

function chineseAdd {
	pacInstall firefox-i18n-zh-tw firefox-i18n-zh-cn
	sudo sed -i 's/#zh_CN.UTF-8/zh_CN.UTF-8/g' /etc/locale.gen
	sudo locale-gen
}
echo "chineseAdd --> installs firefox chinese and adds the locale"

function texliveLangAdd {
	pacInstall texlive-lang
}



function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

