#!/bin/bash

export USERNAME=archlinuxus
export PROJ_DIR="/home/$USERNAME/archlinuxus-scripts"
cd "$PROJ_DIR"

sudo -u $USERNAME install-and-publish/user-main.sh