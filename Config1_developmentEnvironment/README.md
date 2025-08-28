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



Next is to install install parmetis and scotch. 
Without AUR helper, it will be hard 

```
git clone https://aur.archlinux.org/paru.git
cd paru 
makepkg -si
```

Also we need to install some dependencies

```
sudo pacman -S cmake
```
Now for parmetis and scotch:
```
paru -S parmetis
paru -S scotch
```

Now for actual openfoam install, we are not using the Arch Wiki version,
but rather straight from git.

First set the openfoam environment:

```
git clone https://gitlab.com/openfoam/openfoam.git
source openfoam/etc/bashrc
```

Then compile:

```
cd openfoam 
./Allwmake -j -s -q -l
```

Note that i cloned openfoam into this in the folder:

```
$HOME/Documents/research
```


