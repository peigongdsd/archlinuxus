#!/bin/bash -e

if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

function copy-environment-secrets() {
    echo "#!/bin/bash -e" > root.x86_64/root/secret_envs.sh
    env | grep '^REMOTE_' | while read -r line; do
        echo "export $line" >> root.x86_64/root/secret_envs.sh
    done
    chmod +x root.x86_64/root/secret_envs.sh
}

cd "$GITHUB_WORKSPACE"
curl -OL "https://mirrors.edge.kernel.org/archlinux/iso/latest/archlinux-bootstrap-x86_64.tar.zst"
tar -xf archlinux-bootstrap-x86_64.tar.zst --numeric-owner
# archlinuxus-scripts checkouted from git repo
cp -r archlinuxus-scripts root.x86_64/root/
copy-environment-secrets

mount --bind "$PWD/root.x86_64" "$PWD/root.x86_64"
root.x86_64/bin/arch-chroot root.x86_64 /root/archlinuxus-scripts/prepare-arch-env/main.sh
root.x86_64/bin/arch-chroot root.x86_64 /root/archlinuxus-scripts/install-and-publish/main.sh