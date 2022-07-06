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

echo "turnOffBell --> turns off the system beep sound"

function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

function paruInstall {
	paru -S $@ --needed --noconfirm
}
echo "paruInstall [packages] --> executes paru -S --needed --noconfirm"
