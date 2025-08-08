# Introduction

The scariest thing about installing from the Arch USB is the lack of 
a GUI. This does not allow for one to access the installation guide 
nor other helpful resources.

If you are installing arch linux on one computer and that computer is the 
only thing available with which to display install guides, you are probably 
better off using Manjaro or EndeavorOS ISOs.

However, in this day and age, we have plenty of smartphones, tablets and 
other such devices with which to display the install guides. So using the 
USB install medium is okay. 

# Flashing the installation medium

It is easiest to use Balena Etcher to do this for you.

For other methods, please use:
```
https://wiki.archlinux.org/title/USB_flash_installation_medium
```

To verify the installation iso, visit:

```
https://archlinux.org/download/
```

Download both the iso and iso.sig files.

One can then use gpg, which is within most arch linux installs:
```
gpg --verify archlinux-2025.08.01-x86_64.iso.sig archlinux-2025.08.01-x86_64.iso
```



# Disabling secure boot 

For arch-linux installation, it is essential to disable secure boot 
in the UEFI settings before starting. Otherwise, one cannot boot from 
the said medium to install arch.


One can enable secure boot later.

# Connecting to wifi

This is probably most challenging..

But the guide is here:

```
https://wiki.archlinux.org/title/Iwd#iwctl
```

Basically, the simplest is to use iwctl, which is available straight 
from the arch USB install medium. 

This will bring you into an interactive prompt, or custom command line 
environment.

To start this, enter in the bash line:
```
iwctl
```
You should see this before entering:
```
root@archiso ~ # iwctl
```

If you are successful in entering the iwctl command line, you will see:

```
[iwd]#
```

Now, we want to list the device (wifi adapter) we want to use to connect 
to a network.

We use:

```
device list
```
You should see:
```
[iwd]# device list
```

It is common for the device to be named "wlan0" for wifi adapter.

To scan for network over the "wlan0" device, you should see:

```
[iwd]# station wlan0 scan
```
and after this:

```
[iwd]# station wlan0 get-networks
```

You can use tab commands to perform autocompletions and list the 
commands you can use.

To connect to a network names "my-network" using the wifi adapter 
"wlan0", use:

```
[iwd]# station wlan0 connect my-network
```
If prompted for password or passphrase, you will see something like.

```
[iwd]# station wlan0 connect my-network
passphrase:
```

Enter the appropriate password and you will be connected to wifi.

## PEAP server 

Some networks use WPA Enterprise and the EAP-PEAP protocol.

for this, see:

```
https://wiki.archlinux.org/title/Iwd#EAP-PEAP
```

