#!/bin/zsh

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot
function autoInstallGrub {
	#mount $1 /mnt/boot
	grub-install --target=x86_64-efi --efi-directory=/mnt/boot --bootloader-id=archGRUB --boot-directory=/mnt/boot --removable
	touch grubMkconfig.sh
	chmod 755 grubMkconfig.sh
	echo "grub-mkconfig -o /boot/grub/grub.cfg" >> grubMkconfig.sh
	mv grubMkconfig.sh /mnt/root/grubMkconfig.sh
	cp ./grub /mnt/etc/default/grub
	chrootExec /root/grubMkconfig.sh
	rm -rf /mnt/root/grubMkconfig.sh
}

echo "autoInstallGrub --> installs grub onto /mnt/boot with EFI"
echo "it copies the grub default file in the current dir"
echo "and ensures that the grub-mkconfig uses this file \n"

# https://www.atulhost.com/how-to-disable-or-enable-os-prober-from-the-grub
function enableOSProber {
	sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/g' /mnt/etc/default/grub
	vim /mnt/etc/default/grub
	arch-chroot /mnt "grub-mkconfig -o /boot/grub/grub.cfg"
}

echo "new function added: enableOSProber --> enables OS prober in grub"
echo "ensure to mount all the filesystems you want OSprober to work"
echo "on BEFORE using enableOSProber"

function installBiosBoot {
	grub-install --target=i386-pc $1 --recheck
}
echo "[incomplete] installBiosBoot [/dev/sdX] --> installs a grub boot entry into the BIOS"

function chrootExec {
	arch-chroot /mnt $1
}

echo "chrootExec [command] --> executes command as root on /mnt"
