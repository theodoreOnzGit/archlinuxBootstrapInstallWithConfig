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

### network


