#!/bin/zsh

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# for this file, you will be executing commands in the 
# chroot environment

# the chrootExec function
# executes a command in the chroot environment
# assuming the chroot is at /mnt
# credit to:
# https://askubuntu.com/questions/551195/scripting-chroot-how-to

function chrootExec {
	arch-chroot /mnt $1
}


function chrootScriptSetupOnMnt {

	# i'm making a script here of the chroot scripts
	# it will me executed using chrootExec
	rm -rf /mnt/root/chroot.sh
	touch /mnt/root/chroot.sh

	echo "#!/bin/bash" >> /mnt/root/chroot.sh

	# first the timezone
	setupWestCoastTimeZone

	# second is locale ie, keyboard setup
	setup_enUSLocale

	# third is hostname
	setupHostname archExperiment

	# fourth is to setup 
	# boot
	setupBoot

	# last but not least, we need to set password
	addToChrootScriptOnMnt "passwd"

	cat /mnt/root/chroot.sh

	echo " "
	echo "to run the above commands from chroot,"
	echo "chroot into that system, use chmod 755 on that script"
	echo "execute that script"
	
	
}

echo "To setup the scripts for timezone, etc on mnt run chrootScriptSetupOntMnt"
echo "To run that script from chroot"
echo "chroot into that system, use chmod 755 on that script"
echo "execute that script"

function addToChrootScriptOnMnt {
	echo $1 >> /mnt/root/chroot.sh
}

function timezoneSetup {
	addToChrootScriptOnMnt "ln -sf /usr/share/zoneinfo/$1/$2 /etc/localtime"
	addToChrootScriptOnMnt "hwclock --systohc"
}

function setupWestCoastTimeZone {
	timezoneSetup America Los_Angeles
}

function setupSingaporeTimeZone {
	timezoneSetup Asia Singapore
}

function setup_enUSLocale {
	# this script replaces the commented
	# #en_US.UTF-8 with en_US.UTF-8
	addToChrootScriptOnMnt "sed -i 's/#en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen"
	# this next command adds the locale.conf to add 
	# LANG=en.US.UTF-8 
	# to the /etc/locale.conf file
	# first i remove the /etc/locale.conf file if it exists on /mnt
	
	rm -rf /etc/locale.conf
	# then i tell the script to create it and add the info
	addToChrootScriptOnMnt "touch /etc/locale.conf"
	addToChrootScriptOnMnt "echo 'LANG=en_US.UTF-8' >> /etc/locale.conf"
	addToChrootScriptOnMnt "echo 'KEYMAP=us' >> /etc/vconsole.conf"
}

function setupHostname {
	addToChrootScriptOnMnt "touch /etc/hostname"
	addToChrootScriptOnMnt "echo $1 >> /etc/hostname"

}

function setupBoot {
	addToChrootScriptOnMnt "mkinitcpio -P"
	
}
