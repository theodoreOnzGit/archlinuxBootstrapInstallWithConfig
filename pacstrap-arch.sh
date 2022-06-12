#!/bin/zsh

# this file is meant to be sourced, and then you have many functions with
# which to install arch

function pacstrapBase {
	pacstrap /mnt linux linux-firmware base --needed --noconfirm
}

function pacstrapLTSKernels {
	pacstrap /mnt linux-lts --needed --noconfirm
}

function pacstrapVim {
	pacstrap /mnt vim vim-nerdtree vim-latexsuite --needed --noconfirm
	pacstrap /mnt vim-ultisnips vim-vital --needed --noconfirm
}

function pacstrapAndSetupZsh {
	pacstrap /mnt grml-zsh-config zsh-autosuggestions zsh-completions --needed --noconfirm
	pacstrap /mnt zsh-history-substring-search --needed --noconfirm
	pacstrap /mnt zsh-syntax-highlighting --needed --noconfirm
	pacstrap /mnt zsh-theme-powerlevel10k --needed --noconfirm
	echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>/mnt/root/.zshrc
}
# this function pacstraps important tools, eg base-devel, git etc
function pacstrapTools {
	pacstrap /mnt base-devel git github-cli --needed --noconfirm
	pacstrap /mnt neofetch --needed --noconfirm
	pacstrap /mnt arch-install-scripts --needed --noconfirm
}

# this function pacstraps boot tools
function pacstrapBootTools {
	pacstrap /mnt dosfstools --needed --noconfirm
	pacstrap /mnt os-prober grub efibootmgr --needed --noconfirm
	# install both amd ucode and intel ucode 
	# this is for multiboot usb
	pacstrap /mnt amd-ucode intel-ucode
}

function regenerateFstab {
	# lastly i want to regenerate my fstab, according to archwiki
	rm -rf /mnt/etc/fstab
	genfstab -U /mnt
	genfstab -U /mnt >> /mnt/etc/fstab
}

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

