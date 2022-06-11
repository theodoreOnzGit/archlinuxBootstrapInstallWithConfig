#!/bin/zsh

# this file is meant to be sourced, and then you have many functions with
# which to install arch

function pacstrapBase {
	pacstrap /mnt linux linux-firmware base --needed --noconfirm
}
