#!/bin/bash

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot
function coolPropPrereqsInstall() {
	pacInstall mono cython python swig \
		python2-six
}

echo "coolPropPrereqsInstall --> installs mono and etc. for "
echo "for compiling C# compliant shared object .so files"


function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"

