#!/bin/bash -e

USERNAME=archlinuxus
PROJ_DIR=/root/archlinuxus-scripts
/root/secret_envs.sh

source prepare-arch-env/prepare-mirrors.sh
source prepare-arch-env/prepare-software.sh
source prepare-arch-env/prepare-user.sh
source prepare-arch-env/prepare-yay.sh