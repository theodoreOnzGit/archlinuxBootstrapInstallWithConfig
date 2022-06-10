#!/bin/zsh

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
pacman -S vim --needed --noconfirm

# then let's install base-devel and git
pacman -S base-devel git --needed --noconfirm

# finally let's install all the zsh stuff
pacman -S grml-zsh-config zsh-autosuggestions zsh-completions --needed --noconfirm
pacman -S zsh-history-substring-substring-search --needed --noconfirm
pacman -S zsh-syntax-highlighting --needed --noconfirm
pacman -S zsh-theme-powerlevel10k --needed --noconfirm
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# neofetch
pacman -S neofetch --needed --noconfirm


# to use mkfs.fat we need dosfstools
pacman -S dosfstools --needed --noconfirm
