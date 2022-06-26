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

function installVsCodeLatex {
	pacInstall code texlive-most biber
}

echo "installVsCodeLatex --> installs vscode with texlive-most for latex-edits"

function installDotnetCore {
	pacInstall dotnet-runtime dotnet-sdk aspnet-runtime aspnet-targeting-pack

}
echo "installDotnetCore --> installs dotnet Core and asp dotnet core"


function bashAndZshAddons {
	pacInstall bash-completion
}

function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}

echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

