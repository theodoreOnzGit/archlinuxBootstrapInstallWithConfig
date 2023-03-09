#!/bin/bash

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot
function coolPropPrereqsInstall() {
	pacInstall mono cython python swig \
		python2-six p7zip python2
	# http://www.coolprop.org/coolprop/wrappers/Csharp/index.html
}

echo "coolPropPrereqsInstall --> installs mono and etc. for "
echo "for compiling C# compliant shared object .so files \n"

function openfoam_third_party {
	pacInstall boost cgal fftw gcc openmpi paraview utf8cpp
	paruInstall parmetis scotch
}

echo "openfoam_third_party --> Installs boost cgal fftw openmpi"
echo "paraview utf8cpp from arch official repos"
echo "and uses paru to install parmetis and scotch"
echo "these are third party packages required for openfoam-com \n"


function pacInstall {
	sudo pacman -S $@ --needed --noconfirm
}


echo "pacInstall [packages] --> executes sudo pacman -S --needed --noconfirm"


function paruInstall {
	paru -S $@ --needed --noconfirm --sudoloop
}


echo "paruInstall [packages] --> executes paru -S --needed --noconfirm --sudoloop"

