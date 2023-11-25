# Notice

If you use install_tools.sh, please install yay in advance.

## Install yay

```sh
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ../
rm -rf yay
```

## Update packages.txt

If you add new packages, you can update packages.txt with the command below.

```sh
pacman -Qet | awk '{print $1}' > packages.txt
```
