#!/bin/zsh

# this file is meant to be sourced, and then you have many functions with
# which to install arch

function pacstrapBase {
	pacstrap /mnt linux linux-firmware base --needed --noconfirm
}

echo "pacstrapBase --> installs linux linux-firmware and base"

function pacstrapLTSKernels {
	pacstrap /mnt linux-lts --needed --noconfirm
}
echo "pacstrapLTSKernels --> installs linux-lts"

function pacstrapVim {
	pacstrap /mnt vim vim-nerdtree vim-latexsuite --needed --noconfirm
	pacstrap /mnt vim-ultisnips vim-vital --needed --noconfirm
}
echo "pacstrapVim --> installs all nice vim stuff"

function pacstrapAndSetupZsh {
	pacstrap /mnt grml-zsh-config zsh-autosuggestions zsh-completions --needed --noconfirm
	pacstrap /mnt zsh-history-substring-search --needed --noconfirm
	pacstrap /mnt zsh-syntax-highlighting --needed --noconfirm
	pacstrap /mnt zsh-theme-powerlevel10k --needed --noconfirm
	echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>/mnt/root/.zshrc
}
echo "pacstrapAndSetupZsh --> installs zsh with some themes and configs"

# this function pacstraps important tools, eg base-devel, git etc
function pacstrapTools {
	pacstrap /mnt base-devel git github-cli --needed --noconfirm
	pacstrap /mnt neofetch --needed --noconfirm
	pacstrap /mnt arch-install-scripts --needed --noconfirm
}
echo "pacstrapTools --> neofetch, base-devel, arch-instal scripts"

# this function pacstraps boot tools
function pacstrapBootTools {
	pacstrap /mnt dosfstools --needed --noconfirm
	pacstrap /mnt os-prober grub efibootmgr --needed --noconfirm
	# install both amd ucode and intel ucode 
	# this is for multiboot usb
	pacstrap /mnt amd-ucode intel-ucode
}

echo "pacstrapBootTools --> stuff neeeded for formatting"
function regenerateFstab {
	# lastly i want to regenerate my fstab, according to archwiki
	rm -rf /mnt/etc/fstab
	genfstab -U /mnt
	genfstab -U /mnt >> /mnt/etc/fstab
	vim /mnt/etc/fstab
}
echo "regenerateFstab --> generates /mnt/etc/fstab, and brings vim up for you to edit"



# this pacstraps everything previously
function pacstrapAll {
	pacstrapBase
	pacstrapLTSKernels
	pacstrapVim
	pacstrapAndSetupZsh
	pacstrapTools
	pacstrapBootTools
	regenerateFstab
}

echo "pacstrapAll --> does all the above, remember to check /mnt/etc/fstab"

