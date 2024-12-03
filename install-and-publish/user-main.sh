#!/bin/bash -e

export USERNAME=archlinuxus
export PROJ_DIR="/home/$USERNAME/archlinuxus-scripts"

source install-and-publish/install-all-packages.sh
source install-and-publish/yay-cache-to-repo.sh
# source install-and-publish/sync-repo-to-server.sh
