#!/bin/bash -e

function create-user() {
    useradd -m "$USERNAME"
}

function add-user-to-sudoers() {
    echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
}

function copy-to-user-home() {
    cp -r "$PROJ_DIR" "/home/$USERNAME"
    cp /root/secret_envs.sh "/home/$USERNAME"
    chown -R "$USERNAME:$USERNAME" "/home/$USERNAME"
}

create-user
add-user-to-sudoers
copy-to-user-home