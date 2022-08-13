#!/bin/bash

# Install Ansible and set inventory
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo cp hosts.ini /etc/ansible/hosts

# Copy SSH keys to another machine for password-less login
test ! -f ~/.ssh/id_rsa.pub && ssh-keygen -t rsa
for host in `ansible cluster --list-hosts | grep k3s- | sed -e 's/^[ \t]*//'`; do
    ssh-copy-id -i ~/.ssh/id_rsa.pub pi@$host
done

# Get host machine's TZ
# Source: https://unix.stackexchange.com/a/451925
set -euo pipefail

if filename=$(readlink /etc/localtime); then
    # /etc/localtime is a symlink as expected
    timezone=${filename#*zoneinfo/}
    if [[ $timezone = "$filename" || ! $timezone =~ ^[^/]+/[^/]+$ ]]; then
        # not pointing to expected location or not Region/City
        >&2 echo "$filename points to an unexpected location"
        exit 1
    fi
else  # compare files by contents
    # https://stackoverflow.com/questions/12521114/getting-the-canonical-time-zone-name-in-shell-script#comment88637393_12523283
    timezone=find /usr/share/zoneinfo -type f ! -regex ".*/Etc/.*" -exec \
        cmp -s {} /etc/localtime \; -print | sed -e 's@.*/zoneinfo/@@' | head -n1
fi
echo $timezone
