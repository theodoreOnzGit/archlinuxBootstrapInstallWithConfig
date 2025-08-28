# OpenFOAM

We follow the installation guide here:

```
https://wiki.archlinux.org/title/OpenFOAM
```

The prerequisites are as follows:

- openmpi
- paraview
- parmetisAUR
- scotchAUR
- boost-libs
- boost

Parmetis and Scotch need AUR, but for those that don't need AUR, use 

```
sudo pacman -S openmpi paraview boost boost-libs
```



Next is to install install parmetis and scotch. We use the way without 
the AUR helper.

Also we need to install some dependencies

```
sudo pacman -S cmake
```

```
git clone https://aur.archlinux.org/parmetis.git
cd parmetis
makepkg -si 
```


