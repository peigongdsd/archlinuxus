#!/bin/bash -e

su "$USERNAME"
cd "/home/$USERNAME"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm