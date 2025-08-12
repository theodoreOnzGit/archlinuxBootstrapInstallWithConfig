# mounting and pacstrap


## mounting 

suppose you have a btrfs or ext4 partition you wish to use as a linux partition,
The btrfs partition is:

/dev/nvme0n1p2

and the efi system partition is:

/dev/nvme0n1p1



you should use

```
mount /dev/nvme0n1p2 /mnt 
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
```

## pacstrapping (installing the base linux files)

After proper mounting,
```
pacstrap /mnt linux linux-lts linux-firmware base
```

## chrooting into the new install

### basic text editors

To install vim and neovim

```
arch-chroot /mnt
pacman -S vim neovim
```

### timezone setup

For Singapore Timezone,

```
ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime
hwclock --systohc

```

### Keyboard layout, locale etc.

The locales are generated using the locale-gen executable.
The locale-gen executable looks into /etc/locale.gen in order to 
see how to write the locale files

```
sed -i 's/#en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen
locale-gen
```

Then to set the keyboard layout as as english US keyboard:
	
```
rm -rf /etc/locale.conf
touch /etc/locale.conf
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
echo 'KEYMAP=us' >> /etc/vconsole.conf
```

### root password

To set the root password, use:
```
passwd
```

Ensure you are in the right chroot environment.

### network and mirrors

To make life less of a pain when installing, install network drivers and change to local mirrors.


You can clone the git repo here:

```
pacman -S git
https://github.com/theodoreOnzGit/archlinuxBootstrapInstallWithConfig
```

The mirror list is here:

```
##
## Arch Linux repository mirrorlist
## Generated on 2025-08-12
##

## Singapore
#Server = http://mirror.aktkn.sg/archlinux/$repo/os/$arch
#Server = https://mirror.aktkn.sg/archlinux/$repo/os/$arch
#Server = http://mirror.sg.cdn-perfprod.com/archlinux/$repo/os/$arch
#Server = https://mirror.sg.cdn-perfprod.com/archlinux/$repo/os/$arch
#Server = http://sg.mirrors.cicku.me/archlinux/$repo/os/$arch
#Server = https://sg.mirrors.cicku.me/archlinux/$repo/os/$arch
#Server = https://download.nus.edu.sg/mirror/archlinux/$repo/os/$arch
#Server = http://mirror.freedif.org/archlinux/$repo/os/$arch
#Server = https://mirror.freedif.org/archlinux/$repo/os/$arch
#Server = https://singapore.mirror.pkgbuild.com/$repo/os/$arch
#Server = http://mirror.guillaumea.fr/archlinux/$repo/os/$arch
#Server = https://mirror.guillaumea.fr/archlinux/$repo/os/$arch
#Server = http://mirror.jingk.ai/archlinux/$repo/os/$arch
#Server = https://mirror.jingk.ai/archlinux/$repo/os/$arch
#Server = http://sg.arch.niranjan.co/$repo/os/$arch
#Server = https://sg.arch.niranjan.co/$repo/os/$arch
#Server = http://ossmirror.mycloud.services/os/linux/archlinux/$repo/os/$arch
#Server = http://mirror.sg.gs/archlinux/$repo/os/$arch
#Server = https://mirror.sg.gs/archlinux/$repo/os/$arch


```

Alternatively, copy the mirrorlist in the repository to /etc/pacman.d/mirrorlist

(TBC)



