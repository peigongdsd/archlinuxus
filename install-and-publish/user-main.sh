#!/bin/bash -e

/home/$USERNAME/secret_envs.sh

source install-and-publish/install-all-packages.sh
source install-and-publish/yay-cache-to-repo.sh
source install-and-publish/sync-repo-to-server.sh
