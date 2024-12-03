#!/bin/bash -e

function prepare-basic-mirror() {
    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    echo 'Server = https://mirrors.kernel.org/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
}

function prepare-keys() {
    pacman-key --init
    pacman-key --populate
}

function upgrade-and-rank-mirrors() {
    pacman -S pacman-contrib --noconfirm
    awk '/^## United States$/{f=1; next}f==0{next}/^$/{exit}{print substr($0, 1);}' /etc/pacman.d/mirrorlist.backup
    sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
    rankmirrors -n 2 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
}

prepare-basic-mirror
pacman -Syu --noconfirm
prepare-keys
# upgrade-and-rank-mirrors
# echo "ranked mirrors:"
# cat /etc/pacman.d/mirrorlist