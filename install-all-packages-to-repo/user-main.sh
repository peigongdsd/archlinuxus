#!/bin/bash -e

export USERNAME=archlinuxus
export PROJ_DIR="/home/$USERNAME/archlinuxus-scripts"

source install-all-packages-to-repo/install-all-packages.sh
source install-all-packages-to-repo/yay-cache-to-repo.sh
