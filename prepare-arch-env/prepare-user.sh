#!/bin/bash -e

function create-user() {
    # useradd -m "$USERNAME"
    # force the newly add user has a 1000 uid gid.
    groupadd -g 1000 "$USERNAME"
    useradd "$USERNAME" -u 1000 -g 1000 -d "/home/$USERNAME" -s /bin/bash
}

function add-user-to-sudoers() {
    echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
}

create-user
add-user-to-sudoers