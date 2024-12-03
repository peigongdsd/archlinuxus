#!/bin/bash -e
export PROJ_DIR="/home/$USERNAME/archlinuxus-scripts"

/home/$USERNAME/secret_envs.sh
cd "$PROJ_DIR"

source install-and-publish/install-all-packages.sh
source install-and-publish/yay-cache-to-repo.sh
source install-and-publish/sync-repo-to-server.sh
