#!/bin/bash -e

rsync -avz --delete -e "ssh -o StrictHostKeyChecking=no -p $REMOTE_SSH_PORT" "/home/$USERNAME/repo/" "$REMOTE_SSH_USER@$REMOTE_ADDR:$REMOTE_REPO"