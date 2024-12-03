#!/bin/bash -e

USERNAME=archlinuxus

if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

function copy-environment-secrets() {
    echo "#!/bin/bash -e" > root.x86_64/root/secret_envs.sh
    env | grep '^REMOTE_' | grep --invert-match 'REMOTE_SSH_KEY' | while read -r line; do
        echo "export $line" >> root.x86_64/root/secret_envs.sh
    done
    chmod +x root.x86_64/root/secret_envs.sh
    cp root.x86_64/root/secret_envs.sh "root.x86_64/home/$USERNAME"
}

function create-user-home() {
    mkdir -p "root.x86_64/home/$USERNAME"
}

function copy-keys() {
    mkdir -p "root.x86_64/home/$USERNAME/.ssh"
    echo "$REMOTE_SSH_KEY" > "root.x86_64/home/$USERNAME/.ssh/id_ed25519"
}

function copy-project() {
    cp -r archlinuxus-scripts root.x86_64/root/
    cp -r archlinuxus-scripts "root.x86_64/home/$USERNAME/"
}

function fix-user-dir-permissions() {
    chown -R 1000:1000 "root.x86_64/home/$USERNAME"
    chmod 600 "root.x86_64/home/$USERNAME/.ssh/id_ed25519"
}

cd "$GITHUB_WORKSPACE"
curl -OL "https://mirrors.edge.kernel.org/archlinux/iso/latest/archlinux-bootstrap-x86_64.tar.zst"
tar -xf archlinux-bootstrap-x86_64.tar.zst --numeric-owner

# archlinuxus-scripts checkouted from git repo
create-user-home
copy-environment-secrets
copy-keys
copy-project
fix-user-dir-permissions

mount --bind "$PWD/root.x86_64" "$PWD/root.x86_64"
root.x86_64/bin/arch-chroot root.x86_64 /root/archlinuxus-scripts/prepare-arch-env/main.sh
root.x86_64/bin/arch-chroot root.x86_64 /root/archlinuxus-scripts/install-and-publish/main.sh