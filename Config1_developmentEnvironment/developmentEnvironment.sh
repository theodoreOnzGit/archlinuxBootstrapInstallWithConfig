#!/bin/bash

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot
function webBrowsers {
	pacInstall firefox firefox-addons chromium
}

echo "webBroswers --> installs firefox addons and chromium"

function vimLikeWebBrowsers {
	paru -S vieb-bin
}

echo "vimLikeWebBrowsers --> uses paru to install vieb-bin"

function installVimPack {
	pacInstall vim-plugins neovim vim \
		ttf-iosevka-nerd \
		ttf-jetbrains-mono \
		ttf-nerd-fonts-symbols-mono \
	#sudo pacman -Rcs vim-coverage-highlight
	installVimAURAddons
	# don't ever use syntastic for python, it lags like crazy
	sudo pacman -Rcs vim-syntastic
}


function installVimAURAddons {
	paru -S vim-gruvbox-git --needed \
		ttf-meslo-nerd-font-powerlevel10k --needed \
		uctags-git --needed
}

echo "installVimPack --> installs vim addons and neovim"

function installNeovimPack() {
	installVimPack
	# now xclip is used to communicate with
	# system clipboard in GUI interface
	# otherwise, you got to use tmux in
	# order to copy and paste
	pacInstall python-pynvim xclip
	#python3 -m pip install --user --upgrade pynvim
	mkdir -p ~/.config/nvim/
	paru -S neovim-plug nvim-packer-git
	cp ./init.vim ~/.config/nvim/init.vim
}
echo "installNeovimPack --> installs neovim addons and neovim"

function installPythonPack {
	pacInstall python jupyter-notebook  \
		python-pip 

	paru -S nodejs-nodemon
}
echo "installPythonPack --> installs python and jupyter notebook"

function installPython2 (){
	git clone https://aur.archlinux.org/python2.git
	cd python2 && makepkg -si --nocheck
}

echo "installPython2 --> installs python2 via AUR manually"

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
	sudo pacman -Fy
}

function flatpakInstall() {
	pacInstall flatpak
}

echo "flatpakInstall --> installs flatpak "

function dockerInstall() {
	pacInstall docker
	sudo systemctl enable docker --now

}
echo "dockerInstall --> install docker"

gpuTerminalInstall() {
	pacInstall alacritty kitty \
		tmux
}

echo "gpuTerminalInstall --> installs gpu accelerated terminals"
echo "as well as tmux"
echo " "

alacrittySetup() {
	rm -rf $HOME/.alacritty.yml
	cp ./alacritty.yml $HOME/.alacritty.yml
}

echo "alacrittySetup --> sets up alacritty using config file in"
echo "current folder"
echo "WARNING 1: will only work if "
echo "run from Config1_developmentEnvironment"
echo "WARNING 2: will delete current alacritty config file"
echo " "

virtualMachineSetup2022() {
	sudo pacman -S iptables-nft
	pacInstall virt-manager qemu-desktop edk2-ovmf \
		dnsmasq libvirt
	pacInstall virtualbox virtualbox-guest-iso \
		virtualbox-guest-utils \
		virtualbox-host-modules-arch
	LC_ALL=C lscpu | grep Virtualization
	sudo systemctl enable libvirtd
	sudo systemctl start libvirtd
	sudo usermod -G libvirt -a $USER
	echo "remember to start a qemu user session in virt-manager"
	echo " "
	echo "also, if network inactive,"
	echo "sudo virsh net-start default"
	echo " "
}

echo "virtualMachineSetup2022 --> installs virt-manager and virtualBox"
echo " "

virtualOpenGL(){
	pacInstall virglrenderer
#https://bbs.archlinux.org/viewtopic.php?id=273546
}

opcuaCsharpPrereqs(){
	pacInstall openssl-1.0
}


rustSetup(){
	pacInstall rustup rust-analyzer mingw-w64
	rustup default stable
	cargo install cargo-watch
}

echo "rustSetup --> installs rust, cargo and cross compilation"
echo " "

xmlLSPSetupAUR(){
	pacInstall jre-openjdk
	paru -S lemminx
}

echo "xmlLSPSetupAUR --> installs rust, cargo "
echo " "


function aurSetupParu {
	git clone https://aur.archlinux.org/paru.git
	cd paru && makepkg -si && cd ..
}
echo "aurSetupParu --> sets up the paru aur helper"

paruConfig() {
	sudo nvim /etc/paru.conf
}

echo "paruConfig --> edits paru config file with nvim"


function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"
