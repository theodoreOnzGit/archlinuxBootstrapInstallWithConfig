# Paritioning Mounting and Formatting

Paritioning is quite intimidating for a first time 
installer. 

I struggled alot trying to run fdisk for the first time.

So here are some commands to get you started!

But the basic steps here are to make linux and boot partitions
so that you know which part of the disk to install the linux base
files.

After that you want to format them to the right disk format.
For example, the efi boot directory needs to be FAT32 by default
and the main linux directory is usually ext4 by default.

However, you are free to choose other filesystems if you so wish.

# fdisk for partitioning

The classic way to start partitioning a disk is fdisk.
You might want to use lsblk as well. But stick with one tool
use it well. Then move on to other tools. This is what worked
for me.

### ls equivalent (fdisk -l)

To start finding your way around disks attached.
```zsh
fdisk -l
```

For my case, i wanted to install archlinux on a USB drive.
Why? I find that you don't have the real struggle of finding
hardware drivers inside a virtual machine if you use a virtual
machine to practice arch.

The most difficult for me was the bootloader and setting wifi.

Having neither of those was scary to say the least, and it's
important to go through that experience.

However, USB sticks while giving you a "realistic" arch install
experience, in that it's hardware, USBs also give you a lot of
safe space to experiment. So if you mess up your arch install 
somehow, you still get to try again, and not break your system.

Only when you've practiced with USB systems, then install on
laptops.

Okay, so my USB gave this output.

```zsh

Disk /dev/sdb: 14.59 GiB, 15669919744 bytes, 30605312 sectors
Disk model: Cruzer Dial     
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device     Boot   Start      End  Sectors  Size Id Type
/dev/sdb1  *         64  6940215  6940152  3.3G  0 Empty
/dev/sdb2       6940672  7555071   614400  300M ef EFI (FAT-12/16/32)
/dev/sdb3       7555072 30605311 23050240   11G 83 Linux
```
I could tell it was a USB just by looking at the size.
It was 16GB my USb, and 14.59 GB is about 16GB.


### opening a device, like cd /folder (fdisk /dev/sdX)

So since my USB was /dev/sdb i used:

```zsh
fdisk /dev/sdb/
```
and this was the output:

```zsh

Welcome to fdisk (util-linux 2.38).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

This disk is currently in use - repartitioning is probably a bad idea.
It's recommended to umount all file systems, and swapoff all swap
partitions on this disk.


Command (m for help): 
```
For this case i happened to mount /dev/sdb2 and /dev/sdb3.

You may not have this error message, but in case you do, unmount 
the disks.

to exit this interface press q and enter.

I will write more about mounting in a bit.

But let's say that went smoothly and i ran this again:

```zsh
fdisk /dev/sdb/
```
here's what i got:

```zsh

Welcome to fdisk (util-linux 2.38).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): 
```
Now, you got to get comfortable with this interface.

So if you are lost, just press m and enter.
A very long help message will print, (I won't write it here).

But that should help you.

If you want to quit, just press q and enter again.

### printing the partition table (p)

Now let's get you more familiar. If you get lost and want
to see the contents of the folder, like fdisk -l but for
this folder. Press p and enter

```zsh

Command (m for help): p
Disk /dev/sdb: 14.59 GiB, 15669919744 bytes, 30605312 sectors
Disk model: Cruzer Dial     
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device     Boot   Start      End  Sectors  Size Id Type
/dev/sdb1  *         64  6940215  6940152  3.3G  0 Empty
/dev/sdb2       6940672  7555071   614400  300M ef EFI (FAT-12/16/32)
/dev/sdb3       7555072 30605311 23050240   11G 83 Linux

Command (m for help): 
```

m for help and q to quit still apply.


### erasing the disk

Now if you want to erase the disk
and write a new parition, press m for the help bar
and look for the part which says:

```zsh

  Create a new label
   g   create a new empty GPT partition table
   G   create a new empty SGI (IRIX) partition table
   o   create a new empty DOS partition table
   s   create a new empty Sun partition table


```
For most systems in 2022 or later, we want to use GPT partition
table.

I have no idea what it means, but it just works.

```zsh

Command (m for help): g
Created a new GPT disklabel (GUID: 298F2D99-96D1-A445-AC39-BE222CFAFFEE).
The device contains 'dos' signature and it will be removed by a write command.
 See fdisk(8) man page and --wipe option for more details.

```

Oops! What if i didn't want to do that?

just press q and enter. Everything will be okay.

That means no changes are permenant until we save the changes.

q is quit without saving
w is quit and save.


So don't press w until you are sure of what you're doing


### deleting existing partitions (d)

Now, i may not necessarily want to delete everything, 
but if there are existing partitions in there, 

And i want to save them, then I'd rather not wipe out the entire
disk.

So i can selectively delete them.

Now i assume you know how to press m for help in case you
forget the commands. So i won't write about that anymore.

Suppose i want to delete, press d and enter

```zsh

Device     Boot   Start      End  Sectors  Size Id Type
/dev/sdb1  *         64  6940215  6940152  3.3G  0 Empty
/dev/sdb2       6940672  7555071   614400  300M ef EFI (FAT-12/16/32)
/dev/sdb3       7555072 30605311 23050240   11G 83 Linux

Command (m for help): d
Partition number (1-3, default 3):  
```

it will now ask you which partition you want to delete,
sdb1 corresponds to number 1, sdb2 to number 2, and sdb3 to number 3

So if i want to delete 2 and 3, i type the following and get
the result:

```zsh

Command (m for help): d
Partition number (1-3, default 3): 2

Partition 2 has been deleted.
```

repeat the steps for any partition you wish to delete.

and then you can proceed to creating new partitions.













