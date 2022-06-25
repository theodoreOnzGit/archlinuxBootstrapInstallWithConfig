#!/bin/zsh

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot
function autoInstallGrub {
	#mount $1 /mnt/boot
	grub-install --target=x86_64-efi --efi-directory=/mnt/boot --bootloader-id=archGRUB --boot-directory=/mnt/boot --removable
	arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
}

echo "autoInstallGrub --> installs grub onto /mnt/boot with EFI"

# https://www.atulhost.com/how-to-disable-or-enable-os-prober-from-the-grub
function enableOSProber {
	sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLEP_OS_PROBER=false/g' /mnt/etc/default/grub
	vim /mnt/etc/default/grub
	arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
}

echo "new function added: enableOSProber --> enables OS prober in grub"
echo "ensure to mount all the filesystems you want OSprober to work"
echo "on BEFORE using enableOSProber"
