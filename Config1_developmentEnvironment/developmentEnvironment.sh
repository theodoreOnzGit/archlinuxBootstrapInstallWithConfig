#!/bin/bash

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot
function webBrowsers {
	pacInstall firefox firefox-addons chromium
}

echo "webBroswers --> installs firefox addons and chromium"

function installVimPack {
	pacInstall vim-plugins neovim vim \
		ttf-iosevka-nerd \
		ttf-jetbrains-mono \
		ttf-nerd-fonts-symbols-mono \
	#sudo pacman -Rcs vim-coverage-highlight
	installVimAURAddons
}


function installVimAURAddons {
	paru -S vim-youcompleteme-git \
		vim-gruvbox-git \
		ttf-meslo-nerd-font-powerlevel10k

}

echo "installVimPack --> installs vim addons and neovim"

function installPythonPack {
	pacInstall python jupyter-notebook python2 \
		python-pip 
}

echo "installPythonPack --> installs python and jupyter notebook"

function installVsCodeLatex {
	pacInstall code texlive-most biber texlab
}

echo "installVsCodeLatex --> installs vscode with texlive-most for latex-edits"

function installDotnetCore {
	pacInstall dotnet-runtime dotnet-sdk aspnet-runtime aspnet-targeting-pack

}
echo "installDotnetCore --> installs dotnet Core and asp dotnet core"


function bashAndZshAddons {
	pacInstall bash-completion htop ranger w3m elinks atool odt2txt ueberzug
	pacInstall lshw 
	bashAndZshAddonsAUR
}
echo "bashAndZshAddons --> installs bunch of things useful for terminal"

function bashAndZshAddonsAUR {
	paru -S find-the-command --needed 
	echo "source /usr/share/doc/find-the-command/ftc.zsh" >> ~/.zshrc
}

function aurSetupParu {
	git clone https://aur.archlinux.org/paru.git
	cd paru && makepkg -si && cd ..
}
echo "aurSetupParu --> sets up the paru aur helper"

function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

