#!/bin/bash

# this is a pacman install file after we download the correct mirrors and append the correct archlinux keyring
# if we set up those correctly, using https://archlinux.org/mirrorlist/
# we can start populating the keyring straightaway
#

pacman-key --init
pacman-key --populate

# immediately after we must update the keyring and 
# and update the packages

pacman -S archlinux-keyring --needed --noconfirm
pacman -Syyu --needed --noconfirm

# first thing is to install vim, super important!
pacman -S vim vim-nerdtree --needed --noconfirm

# then let's install base-devel git and github
pacman -S base-devel git github-cli --needed --noconfirm

# finally let's install all the zsh stuff
pacman -S grml-zsh-config zsh-autosuggestions zsh-completions --needed --noconfirm
pacman -S zsh-history-substring-search --needed --noconfirm
pacman -S zsh-syntax-highlighting --needed --noconfirm
pacman -S zsh-theme-powerlevel10k --needed --noconfirm
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# neofetch
pacman -S neofetch --needed --noconfirm


# to use mkfs.fat we need dosfstools
pacman -S dosfstools --needed --noconfirm

# grub tools and ntfs formatter for windows partitions
pacman -S os-prober grub efibootmgr --needed --noconfirm
pacman -S ntfs-3g --needed --noconfirm

# ranger: a vim like command line file manager
pacman -S ranger --needed --noconfirm

# copy .vimrc and .bashrc to /root/.
cp ../.vimrc /root/.
cp ../.bashrc /root/.




