#!/bin/zsh

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot
function autoInstallGrub {
	mount $1 /mnt/boot
	grub-install --target=x86_64-efi --efi-directory=/mnt/boot --bootloader-id=archGRUB --boot-directory=/mnt/boot --removable
	grub-mkconfig -o /mnt/boot/grub/grub.cfg
}

# https://www.atulhost.com/how-to-disable-or-enable-os-prober-from-the-grub
function enableOSProber {
	sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLEP_OS_PROBER=false/g' /mnt/etc/default/grub
	grub-mkconfig -o /mnt/boot/grub/grub.cfg
}
