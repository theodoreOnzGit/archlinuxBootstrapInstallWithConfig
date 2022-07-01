#!/bin/bash


# this file is meant to be sourced, and then you have many functions with
# which to install arch

# for this file, you will be executing commands in the 
# chroot environment

# the chrootExec function
# executes a command in the chroot environment
# assuming the chroot is at /mnt
# credit to:
# https://askubuntu.com/questions/551195/scripting-chroot-how-to

echo "NOTE: scripts are meant to be run from bootstrap, NOT chrooted"
echo "in your installation!"

echo " "
echo " "
function chrootExec {
	touch chrootExec.sh
	chmod 755 chrootExec.sh
	echo $1 >> chrootExec.sh
	rm -rf /mnt/root/chrootExec.sh
	mv chrootExec.sh /mnt/root/chrootExec.sh
	arch-chroot /mnt /root/chrootExec.sh
	rm -rf /mnt/root/chrootExec.sh
}

echo "chrootExec [COMMAND] --> execute command from chroot"

function addHostName {

	# first clean up the hostname file, 
	# then put the hostname there
	rm -rf /mnt/etc/hostname
	touch /mnt/etc/hostname
	echo $1 >> /mnt/etc/hostname

	echo " "
	echo "on /mnt/etc/hostname:"
	cat /mnt/etc/hostname

	# next is /etc/hosts
	rm -rf /mnt/etc/hosts
	touch /mnt/etc/hosts
	echo "127.0.0.1		localhost" >> /mnt/etc/hosts
	echo "::1			localhost" >> /mnt/etc/hosts
	echo "127.0.0.1		$1" >> /mnt/etc/hosts

	echo " "
	echo "on /mnt/etc/hosts:"
	cat /mnt/etc/hosts

}

echo "addHostName [hostname] --> add hostname to /etc/hostname and /etc/hosts"
echo "warning: will overwrite any existing file"

function addSambaDNS {
	pacstrap /mnt samba --needed --noconfirm
	chrootExec "systemctl enable nmb"
}


echo "addSambaDNS --> enable microsoft netbios hostname resolution,"
echo "Note: installs samba"

function addNetworkManager {
	pacstrap /mnt networkmanager --needed --noconfirm
	chrootExec "systemctl enable NetworkManager"
}

echo "addNetworkManager --> adds the network manager cli and enables it with"
echo "systemctl enable"

function addBlueTooth {
	pacstrapInstallToMnt bluez --needed --noconfirm

}
echo "addBlueTooth --> adds bluetooth package"
echo "systemctl enable"


# with a network setup, you can autoupdate mirrors
# using a reflector service
function reflectorSetup {
	pacstrapInstallToMnt reflector
	echo "--country United States, Singapore, France, Germany" >> /mnt/etc/xdg/reflector/reflector.conf
	chrootExec "systemctl enable reflector"
}

echo "reflectorSetup --> installs reflector "
echo "also adds the reflector service to autoupdate mirrors"
echo "my specific script is United States, Singapore, France, Germany"

function dhcpSetup {
	pacstrapInstallToMnt dhcpcd
	chrootExec "systemctl enable dhcpcd"
}

echo "dhcpSetup --> sets up dhcp client daemon for dyanmic IP address"

function pacstrapInstallToMnt {
	pacstrap /mnt $1 --needed --noconfirm
}

function autoInstallNetwork {
	addHostName $1
	addNetworkManager
	addSambaDNS
	dhcpSetup
	addBlueTooth
	reflectorSetup
}

echo "autoInstallNetwork [hostname] --> installs and setups up network with all above"
echo "scripts"
