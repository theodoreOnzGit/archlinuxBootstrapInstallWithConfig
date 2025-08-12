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



```
```

(TBC)



