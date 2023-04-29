#!/bin/bash

function listSchedulers {
	grep "" /sys/block/*/queue/scheduler
}

echo "listSchedulers --> list available schedulers for all disks"

function changeToBfq {
	echo bfq > /sys/block/$1/queue/scheduler
}

echo "changeToBfq [sdX] --> changes the scheduler to bfq, good for disks"
echo "with slow IO"

function turnOffBell() {
	sudo sed -i 's/#set bell-style none/set bell-style none/g' /etc/inputrc
	#https://wiki.archlinux.org/title/PC_speaker
	sudo rmmod pcspkr
	sudo su -c "rm -rf /etc/modprobe.d/nobeep.conf"
	sudo su -c "touch /etc/modprobe.d/nobeep.conf"
	sudo su -c 'echo "blacklist pcspkr" >> /etc/modprobe.d/nobeep.conf'
}

echo ""
echo "turnOffBell --> turns off the system beep sound"

function tuxedoControlCenter() {
	paruInstall tuxedo-control-center-bin power-profiles-daemon
	sudo systemctl enable power-profiles-daemon
}
echo ""
echo "tuxedoControlCenter --> installs tuxedo-control-center-bin
and power-profiles-daemon for power, fan and temperature control"

function thermaldSuite() {
	paruInstall thermald auto-cpufreq-git power-profiles-daemon
	sudo systemctl enable power-profiles-daemon
	sudo systemctl enable thermald
	sudo systemctl enable auto-cpufreq
}
echo ""
echo "thermaldSuite --> installs thermald
and power-profiles-daemon for power and temperature control"

overscanFixToolsInstall() {
	pacInstall arandr
}

echo "overscanFixToolsInstall --> installs arander to fix overscan"
echo "overscan is when the screen gets cut off on screen corners"

underscanFix() {
	pacInstall xorg-xrandr
	xrandr
	xrandr --output $1 --set underscan on \
		--set "underscan vborder" $3 \
		--set "underscan hborder" $2
	#https://wiki.archlinux.org/title/xrandr#Correction_of_overscan_tv_resolutions_via_the_underscan_property
}

echo " "
echo "underscanFix [display name] [horizontal pixels] [vertical pixels]"
echo "--> fixes overscan if the screen stretches beyond the monitor"
echo "enter the horizontal and vertical pixels to fix"
echo "how much border to add to vertical and horizontal pixels"
echo " "

underscanFixLenovoIdeaPad3() {
	underscanFix HDMI-A-0 115 55
}

echo " "
echo "underscanFixLenovoIdeaPad3 --> fixes my personal ideapad 3 with HDMI-A-0"
echo " "

function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

function paruInstall {
	paru -S $@ --needed --noconfirm
}
echo "paruInstall [packages] --> executes paru -S --needed --noconfirm"
