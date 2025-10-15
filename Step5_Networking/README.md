# Networking

Setting up networking, while not essential for barebones arch, 
is essential for getting arch usable.

Without networking, you cannot run pacman or install stuff
from the AUR. You cannot use git etc.

IMO, i consider it essential.

# Connecting to wifi (GUI)

Connecting to wifi in GUI is usually done using Network Manager 
with WPA supplicant backend.



# Connecting to wifi (Terminal)

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

Enter the appropriate password and you will be connecteied to wifi.

# sharing wifi over network manager 

To share wifi, follow this link:
```
https://wiki.archlinux.org/title/Software_access_point
```

In addition to network manager, you need to install:
```
sudo pacman -S dnsmasq
```

## PEAP server 

Some networks use WPA Enterprise and the EAP-PEAP protocol.

for this, see:

```
https://wiki.archlinux.org/title/Iwd#EAP-PEAP
```

(not quite sure how to connect this yet)
Probably do a successful connection using iwd, and check the config file 
then.


# Problems Encountered

## iwd and Network Manager Conflict

When I installed a new Arch plus cinnamon desktop,
the package comes installed with network manager with WPA supplicant backend.

Now, the wifi protocol is a PEAP type connection. Network manager plus 
WPA supplicant is able to connect to it no problem. 

Nevertheless, installing arch requires internet connection even within the 
terminal. So I want to use the terminal to connect to a PEAP wifi 
for the Arch installation medium.

Wanting to practice this on an already working Arch system,
I tried to use iwd to connect to wifi using PEAP protocol.

I installed iwd

```
sudo pacman -S iwd
```

and enabled it:

```
sudo systemctl enable iwd
sudo systemctl start iwd
``` 

This enabled me to use iwctl.
Then I tried setting PEAP connection in iwctl.

Doing so, I found that I gotten an error that the network wasn't properly configured.

Similar to
```
https://www.reddit.com/r/archlinux/comments/1b0fdeb/iwd_on_peap_without_certificate/
```

Without certificate, it is hard to get the PEAP connection to work. 
But the PEAP connection here doesn't need a CA-certificate.

Searching online, I saw that for Android Systems (essentially Linux), the 
solution was to use system CA-certificates. 

I tried searching for an equivalent in Arch Linux but to no avail.
As in, I tried to find existing ca-certificates in the Arch Linux packages:

```
https://archlinux.org/packages/core/any/ca-certificates/
```

This was not working.

I also tried downloading CA-certificates manually. But that wasn't working either.
I thought to download root certificates.

This was confusing:
```
https://wiki.archlinux.org/title/User:Grawity/Adding_a_trusted_CA_certificate
```

I tried the solution here:

```
https://bbs.archlinux.org/viewtopic.php?id=273097
```

which was:
```
wget http://netfree.link/netfree-ca.crt
sudo trust anchor --store netfree-ca.crt
```

The url returned an error. I'm not even sure what certificate i should be 
downloading. This was very frustrating.

I have concluded that using iwd for this specific PEAP network 
was not quite suitable. Not simple at all.

Network manager with WPA supplicant seemed to be better.
I rather just use that.

I thought perhaps if I used network manager with iwd as the backend, i could 
get a suitable configuration file for iwd autoconfigured.

So, I tried asking network manager to use iwd as a wifi backend instead of 
WPA supplicant. Now, NetworkManager (GUI) doesn't quite work but iwd does.

And neither the Network Manager nor iwd terminal can connect to the PEAP 
wifi. Moreover, these packages seem to conflict and now NetworkManager is 
botched.

Some ppl have experienced this issue before:

```
https://bbs.archlinux.org/viewtopic.php?id=292603
```

I'm tentatively abandoning the iwd route for the PEAP network, and perhaps try 
nmcli instead. As in nmcli is Network Manager cli. I cannot get iwd to work,
perhaps using ncmli is better as it can work in the arch install usb, and also 
in the GUI....


Now I want to disable the whole iwd thing, and move to nmcli. Not sure how to undo 
the botching of network manager. Will have to work on that next.

For now, working with network manager is good. One has to use root user to 
access

```
/etc/NetworkManager/system-connections
```

In this file NUS.nmconnection:

```
[connection]
id=NUS
uuid=24fc2b82-db84-4ab1-b530-2c8ebe93473f
type=wifi
interface-name=wlp0s20f3

[wifi]
mode=infrastructure
ssid=NUS

[wifi-security]
auth-alg=open
key-mgmt=wpa-eap

[802-1x]
domain-suffix-match=auth01.nw.nus.edu.sg
eap=peap;
identity=my_username
password=my_password
phase2-auth=mschapv2

[ipv4]
method=auto

[ipv6]
addr-gen-mode=default
method=auto

[proxy]
```

Now, dealing with this PEAP wifi security has been nothing short of frustrating.
But one thing that did seem to work as a temporary measure is to change hostname.

```
/etc/hostname
```

This sort of works sometimes, but doesn't at others..
