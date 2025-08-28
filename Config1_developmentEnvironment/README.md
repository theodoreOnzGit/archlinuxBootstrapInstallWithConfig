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


# OpenMC

With OpenMC, one normally installs using:

```
git clone --recurse-submodules https://github.com/openmc-dev/openmc.git
cd openmc
mkdir build && cd build
cmake ..
make
sudo make install
```

Taken from:

```
https://docs.openmc.org/en/stable/quickinstall.html
```

The problem with this is that openmc is installed into:

```
/usr/lib/bin
```

This puts OpenMC together with all the other programs. Which is messy 
program management. If I want to uninstall it, i will have to navigate 
back to this folder and find the individual files openmc installed.

I'd rather have it elsewhere for neatness sake.

If one wants it elsewhere, the cmake command should be:

```
cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local ..
```

Let's say I want this in $HOME/Documents/research/openmcbin:

```
git clone --recurse-submodules https://github.com/openmc-dev/openmc.git
cd openmc
mkdir build && cd build
mkdir $HOME/Documents/research/openmcbin
cmake -DCMAKE_INSTALL_PREFIX=$HOME/Documents/research/openmcbin ..
make
sudo make install
```

Doing this should put the binaries inside the openmcbin folder. 
However, you will have to run openmc from the folder.

If you want to access it anywhere, you will need to add this to the path 
variable. 

This is under:

```
https://wiki.archlinux.org/title/Environment_variables
```

To print environment variables use:

```
printenv
```


So, to add openmcbin to the path variable:

```
export PATH="${PATH}:$HOME/Documents/research/openmcbin/bin"
```













































