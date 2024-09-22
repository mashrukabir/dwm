#!/bin/bash

# Optimizations
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
sudo sed -i '/\[options\]/a\ILoveCandy' /etc/pacman.conf
sudo sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
sudo sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nc\"/g" /etc/makepkg.conf
sudo sed -i "s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g" /etc/makepkg.conf
sudo sed -i 's/^timeout 3/timeout 0/' /boot/loader/loader.conf

echo -e "\e[1;34mInstalling AUR helper...\e[0m"
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin || exit && makepkg -si --noconfirm
cd .. && rm -rf paru-bin

echo -e "\e[1;33mInstalling applications\e[0m"
paru -S --noconfirm --needed xorg-server xorg-xinit xorg-xrandr xorg-xsetroot picom libxft noto-fonts noto-fonts-emoji alacritty mpv libxinerama lxappearance brightnessctl pulsemixer playerctl pamixer flameshot fastfetch btop polkit-gnome feh xtrlock papirus-icon-theme blueman
sudo systemctl enable bluetooth

# Thunar
./thunar.sh
clear

# Apps
paru -S --noconfirm --needed obsidian signal-desktop syncthing keepassxc vulkan-headers librewolf-bin vscodium-bin qview-git
clear && cd

git clone https://github.com/mashrukk/dwm
mv dwm/ wm

echo -e "\e[1;32mInstalling dwm, dmenu, and slstatus...\e[0m"
cd wm/dwm || exit
sudo make clean install
cd ../dmenu || exit
sudo make clean install
cd ../slstatus || exit
sudo make clean install
cd && mv wm/xinitrc ~/.xinitrc

mkdir -p ~/Pictures/{Wallpapers,Screenshots} ~/Downloads ~/Videos ~/Documents/Shared ~/.local/share/{icons,fonts,themes}
mv ~/wm/alacritty ~/.config/
mv wm/wall.jpg Pictures/Wallpapers

curl -LO https://github.com/ful1e5/Bibata_Cursor/releases/latest/download/Bibata-Modern-Ice.tar.xz
tar -xvf Bibata-Modern-Ice.tar.xz -C ~/.local/share/icons/
mv ~/.local/share/icons/Bibata-Modern-Ice ~/.local/share/icons/cursor
rm Bibata-Modern-Ice.tar.xz

git clone https://github.com/daniruiz/flat-remix-gtk.git && cd flat-remix-gtk
cp -r themes/Flat-Remix-GTK-Blue-Darkest-Solid ~/.local/share/themes/Flat-Remix
cd .. && rm -rf flat-remix-gtk

rm ~/wm/scripts/{install.sh,thunar.sh} && cd && startx
