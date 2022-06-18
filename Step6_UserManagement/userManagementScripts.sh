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
	arch-chroot /mnt $1
}

echo "chrootExec [COMMAND] --> execute command from chroot"

function addSudoUser {
	echo "setting username $1"
	chrootExec "useradd -m $1"
	chrootExec "usermod -aG wheel $1"
	chrootExec "passwd $1"

}

echo "addSudoUser [username] --> addes a username specified to the wheel group"
echo "and also allows you to configure a password"

function removeUser {
	chrootExec "userdel -r $1"
}

echo "removeUser [username] --> removes a user, in case something goes wrong"

function addGuestUser {
	echo "setting username $1"
	chrootExec "useradd -m $1"
	chrootExec "passwd $1"

}

echo "addGuestUser [username] --> addes a username specified with no sudo privileges"
echo "and also allows you to configure a password"

function vimSudo {
	# basically, i'm making a script file
	# executing it with arch-chroot
	# then deleting the file once done
	touch vimsudo.sh
	echo "EDITOR=vim visudo" >> vimsudo.sh
	chmod 755 vimsudo.sh
	mv vimsudo.sh /mnt/root/vimsudo.sh
	chrootExec /root/vimsudo.sh
	rm -rf /mnt/root/vimsudo.sh

}

echo "vimSudo --> executes visudo with vim editor to edit the sudoers file"
echo "make sure you add the line: %wheel ALL=(ALL:ALL) ALL"


function setupSudoUser {
	vimSudo
	addSudoUser $1
}

echo "setupSudoUser [username] --> executes visudo and adds a sudo user"

function addSimpleVimrc {
	touch .vimrc

	echoToVimRc "set relativenumber"
	echoToVimRc "set number"

	echoToVimRc "set nowrap"
	echoToVimRc "syntax on"
	echoToVimRc "filetype indent on"
	echoToVimRc "filetype plugin indent on"

	echoToVimRc "set tabstop=4"
	echoToVimRc "set shiftwidth=4"
	echoToVimRc "set scrolloff=5"

	echoToVimRc "color slate"

	echoToVimRc '" nerdtree settings if you want to enable them'
	echoToVimRc '" let NERDTreeShowHidden=1'
	echoToVimRc '" autocmd VimEnter * NERDTree | set number |set relativenumber| wincmd l | wincmd l'
	echoToVimRc '"'

	echoToVimRc 'vsplit'
	echoToVimRc 'terminal'

	cp .vimrc /mnt/root/.vimrc
	mv .vimrc /mnt/home/$1/.vimrc
}

echo "addSimpleVimrc [username] --> adds a simple .vimrc file to both the specified user and root"
echo "warning, may override existing .vimrc files!"

function echoToVimRc {
	echo $1 >> .vimrc

}

function addSimpleBashrc {
	touch .bashrc

	echoToBashRc '#!/bin/bash'
	echoToBashRc 'alias ls="ls --color=auto"'
	echoToBashRc 'alias l="ls -aCF"'
	echoToBashRc 'alias dir="dir --color=auto"'
	echoToBashRc 'alias grep="grep --color=auto"'
	echoToBashRc "alias dmesg='dmesg --color'"
	echoToBashRc 'alias pacman="pacman --color=auto"'
	echoToBashRc ''
	echoToBashRc '# The following files are copied from manjaro bashrc'
	echoToBashRc '# ~/.bashrc'
	echoToBashRc '#'
	echoToBashRc ''
	echoToBashRc '[[ $- != *i* ]] && return'
	echoToBashRc ''
	echoToBashRc 'colors() {'
	echoToBashRc '	local fgc bgc vals seq0'
	echoToBashRc ''
	echoToBashRc '	printf "Color escapes are %s\n" "\e[${value};...;${value}m'
	echoToBashRc '	printf "Values 30..37 are \e[33mforeground colors\e[m\n"'
	echoToBashRc '	printf "Values 40..47 are \e[43mbackground colors\e[m\n"'
	echoToBashRc '	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"'
	echoToBashRc ''
	echoToBashRc '	# foreground colors'
	echoToBashRc '	for fgc in {30..37}; do'
	echoToBashRc '		# background colors'
	echoToBashRc '		for bgc in {40..47}; do'
	echoToBashRc '			fgc=${fgc#37} # white'
	echoToBashRc '			bgc=${bgc#40} # black'
	echoToBashRc ''
	echoToBashRc '			vals="${fgc:+$fgc;}${bgc}"'
	echoToBashRc '			vals=${vals%%;}'
	echoToBashRc ''
	echoToBashRc '			seq0="${vals:+\e[${vals}m}"'
	echoToBashRc '			printf "  %-9s" "${seq0:-(default)}"'
	echoToBashRc '			printf " ${seq0}TEXT\e[m"'
	echoToBashRc '			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"'
	echoToBashRc '		done'
	echoToBashRc '		echo; echo'
	echoToBashRc '	done'
	echoToBashRc '}'
	echoToBashRc ''
	echoToBashRc '[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion'
	echoToBashRc ''
	echoToBashRc ''
	echoToBashRc ''
	echoToBashRc ''
	echoToBashRc 'xhost +local:root > /dev/null 2>&1'
	echoToBashRc ''
	echoToBashRc "# Bash won't get SIGWINCH if another process is in the foreground."
	echoToBashRc '# Enable checkwinsize so that bash will check the terminal size when'
	echoToBashRc '# it regains control.  #65623'
	echoToBashRc '# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)'
	echoToBashRc 'shopt -s checkwinsize'
	echoToBashRc ''
	echoToBashRc 'shopt -s expand_aliases'
	echoToBashRc ''
	echoToBashRc '# export QT_SELECT=4'
	echoToBashRc ''
	echoToBashRc '# Enable history appending instead of overwriting.  #139609'
	echoToBashRc 'shopt -s histappend'

	cp .bashrc /mnt/root/.bashrc
	mv .bashrc /mnt/home/$1/.bashrc

}

echo "addSimpleBashrc [username] --> adds a simple .bashrc file to both the specified user and root"
echo "warning, may override existing .bashrc files!"

function echoToBashRc {
	echo $1 >> .bashrc
}


function autoSetupUser {
	setupSudoUser $1
	addGuestUser $2
	addSimpleVimrc $1
	addSimpleVimrc $2
	addSimpleBashrc $1
	addSimpleBashrc $2

}

echo "autoSetupUser [sudoUsername] [guestUsername] --> adds a guest user, a sudo user and adds a bashrc and vimrc file to them"
echo "warning, may override existing .bashrc files!"
