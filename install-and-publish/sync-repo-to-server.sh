#!/bin/bash -e

echo "$REMOTE_SSH_KEY" > "/home/$USERNAME/.ssh/id_ed25519"
rsync -avz -e "ssh -p $REMOTE_SSH_PORT" "/home/$USERNAME/repo/ $REMOTE_SSH_USER@$REMOTE_ADDR:$REMOTE_REPO"