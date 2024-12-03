#!/bin/bash -e

function copy-environment-secrets() {
    echo "#!/bin/bash -e" > root.x86_64/root/secret_envs.sh
    env | grep '^GITHUB_' | while read -r line; do
        echo "export $line" >> root.x86_64/root/secret_envs.sh
    done
    chmod +x root.x86_64/root/secret_envs.sh
}

curl -OL "https://mirrors.edge.kernel.org/archlinux/iso/latest/archlinux-bootstrap-x86_64.tar.zst"
tar -xf archlinux-bootstrap-x86_64.tar.zst --numeric-owner
# archlinuxus-scripts checkouted from git repo
cp -r archlinuxus-scripts root.x86_64/root/
copy-environment-secrets

mount --bind $PWD/root.x86_64 $PWD/root.x86_64
sudo root.x86_64/bin/arch-chroot root.x86_64 /root/archlinuxus-scripts/prepare-arch-env/main.sh
sudo root.x86_64/bin/arch-chroot root.x86_64 /root/archlinuxus-scripts/install-and-publish/main.sh