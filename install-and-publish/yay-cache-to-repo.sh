#!/bin/bash -e

function prepare-repo() {
    mkdir -p /home/$USERNAME/repo/x86_64
}

function move-all-packages-to-repo() {
    find /home/$USERNAME/.cache/yay -name "*.pkg.tar.zst" -exec mv -t /home/$USERNAME/repo/x86_64/ {} +
}

# function import-gnupg-key() {
#     gpg --import /home/$USERNAME/.gnupg/pubring.kbx
# }

function generate-db-file() {
    # use -s -k key to add signature, we simply skip the signing stage.
    repo-add /home/$USERNAME/repo/x86_64/archlinuxus.db.tar.gz /home/$USERNAME/repo/x86_64/*.pkg.tar.zst
}

prepare-repo
move-all-packages-to-repo
generate-db-file