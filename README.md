# ArchLinuxBootstrapInstallWithConfig
A collection of config files and scripts to help with arch bootstrap 
while installing arch from manjaro

# Purpose

Installing Arch Linux is challenging as it is.

Of the many methods to use to install Arch Linux, 
I have chosen to install it from my 
[existing](https://wiki.archlinux.org/title/Install_Arch_Linux_from_existing_Linux) 
linux manjaro distribution. The alternative is EndeavorOS.

The way to do so is using a bootstrap. This is because connecting to 
a wifi network in the command line can be quite intimidating. The 
installation medium for EndeavorOS or Manjaro does make the wifi 
connection part relatively straightforward. However, one still needs 
to configure the bootstrap before starting out.

This repository contains a number of things i found useful
while installing arch.

Also, if one finds it easier to install straight from the arch USB medium,
I've included some steps there as well.

# Description for Bootstrap Install

This git repository contains scripts to help automate an arch install.
Other scripts and installers do exist, but this installer tries to
stick strictly to bash scripting so that the arch installation
will retain the customisability of arch, with at least some recommended 
steps to get an arch setup working. 

## Steps (essential), execute in bootstrap environment

The folders are labelled StepX where X is a number. 
Step 0 sets up the bootstrap environment.

Steps 1-7 are meant to be run from a bootstrap environment.

Step 1-5 are absolutely essential as they guide you to install an
arch distribution and setup a root password.

Step 6-7 help you create a sudo user and a desktop GUI (KDE).



## Config (extra and customisation) - execute in arch desktop

The step folders here are meant to be executed from the arch desktop 
environment 


# Description for arch ISO install




