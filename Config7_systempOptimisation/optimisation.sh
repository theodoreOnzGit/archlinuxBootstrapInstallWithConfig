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

function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

function paruInstall {
	paru -S $@ --needed --noconfirm
}
echo "paruInstall [packages] --> executes paru -S --needed --noconfirm"
