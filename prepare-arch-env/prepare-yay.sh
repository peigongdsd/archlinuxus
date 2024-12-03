#!/bin/bash -e

cd "/home/$USERNAME"
sudo -u "$USERNAME" git clone https://aur.archlinux.org/yay.git
cd yay
sudo -u "$USERNAME" makepkg -si --noconfirm