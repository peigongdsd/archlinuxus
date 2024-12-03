#!/bin/bash -e
USERNAME=archlinuxus
PROJ_DIR=/home/$USERNAME/archlinuxus-scripts

/home/$USERNAME/secret_envs.sh

su "$USERNAME"
cd "$PROJ_DIR"

source install-and-publish/install-all-packages.sh
source install-and-publish/sync-repo-to-server.sh
source install-and-publish/yay-cache-to-repo.sh
