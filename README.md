Not finished yet!

---

# ioBroker.dotfiles
dotfiles for Bash (debian) with some enhancements for ioBroker

Screenshot with Terminal https://github.com/Eugeny/terminus

![Screenshot](screenshot.png)

## INSTALL
```
mkdir ~/iobroker-dotfiles
cd ~/iobroker-dotfiles
git clone https://github.com/darkiop/ioBroker.dotfiles.git .
./install-applications.sh
source ~/iobroker-dotfiles/bashrc
```
## DOCUMENTATION

### alias

#### iobl

use 'lnav' (http://lnav.org/) to follow the current ioBroker logfile.
More information about lnav under https://wiki.ubuntuusers.de/lnav/

### motd

#### motd-iobroker.sh

shows the current state of the running ioBroker Adaptes. Defined in motd/motd-iobroker.sh:

```
...

# iobroker process-check
echo
echo -e $light_blue_color"ioBroker instances:"$green_color

process=(
  "iobroker.js-controller" 
  "io.admin.0" 
  "io.backitup.0" 
  "io.bring.0" 
  "io.harmony.0" 
  ...
)
```
