# Introduction 

bootloading is one of the most challenging parts to get right in Arch.
To understand bootloading, we will need some context about the boot process.
This makes manually setting boot directory, as with anything else in 
Arch, quite an involved process.

Of course, there can be a set of instructions given provided you know what 
you are doing.

Will probably write those out here later.

# Boot process 

For boot process, your firmware manager will look for a BIOS or UEFI 
partition. This BIOS or UEFI will be the first entry that the computer looks 
for in order to boot.

The boot process can be summarised (ish) as:

1. Look for UEFI partition on the appropriate disk. This is selected in 
the boot selection menu in the UEFI-firmware settings. 
2. look for an executable within said UEFI partition, eg GRUB
3. GRUB will then load boot entries in its manual based on the grub.cfg file
4. Thereafter, the rest of the boot processes will start, including 
mounting of filesystems.


## UEFI-firmware settings 

Basically, this is where you select your boot device. This is done by 
pressing some key, eg. F1, F2, F7 or F12 shortly after the computer boots 
up. You will need to check the model of your computer to see what key 
to press. 

You then have some sort of menu to select a boot device. This will usually 
have a UEFI bootloader.

## UEFI Bootloader and Partition

Most modern systems use a UEFI bootloader.
This stands for Unified Extensible Firmware Interface (UEFI).

The UEFI boot entries live on a FAT partition, usually FAT32.

So in Arch, we usually make a boot partition for this. We like to call this 
the EFI partition where the bootloader entries live.

To make this partition and make it bootable, we usually:

1. set aside about 1-3GB of space.
2. Format this using FAT, eg. FAT32
3. Use the grub-install command

The most basic way to install it is, when inside the root directory, and 
with the FAT partition mounted at /boot:

```
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
```



## Grub 

To load the operating system, 






