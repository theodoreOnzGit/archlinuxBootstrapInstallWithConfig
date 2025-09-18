# Power management 

One of the most important things for power management is temperature control.
This is especially so for laptops, which can easily overheat.

## Powertop

For power and temperature management, it is good to use powertop.

```
sudo pacman -S powertop
```

To use powertop to tune parameters to make them sane (if not we will 
experience overheat):

```
sudo powertop --auto-tune
```

I've not yet figured how to set this to activate at startup. This is 
still work in progress. I do not fully understand this yet.

to automate this, as per the arch wiki:
```
https://wiki.archlinux.org/title/Powertop#Apply_settings
```

create a custom powertop.service file under:

```
/etc/systemd/system/powertop.service
```

In this text file:

```
[Unit]
Description=Powertop tunings

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/powertop --auto-tune

[Install]
WantedBy=multi-user.target sleep.target
```

after that:

```
sudo systemctl enable powertop
sudo systemctl start powertop
```

This should ensure the powertop tuning works on startup
