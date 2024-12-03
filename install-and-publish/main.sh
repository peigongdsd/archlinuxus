#!/bin/bash -e
export USERNAME=archlinuxus
export PROJ_DIR=/home/$USERNAME/archlinuxus-scripts

/home/$USERNAME/secret_envs.sh
cd "$PROJ_DIR"

sudo -u $USERNAME --preserve-env bash install-and-publish/install-all-packages.sh
sudo -u $USERNAME --preserve-env bash install-and-publish/yay-cache-to-repo.sh
sudo -u $USERNAME --preserve-env bash install-and-publish/sync-repo-to-server.sh
