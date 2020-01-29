#!/bin/bash
test ! -f ~/.ssh/id_rsa.pub && ssh-keygen -t rsa
for host in `ansible k3s-cluster --list-hosts | grep k3s- | sed -e 's/^[ \t]*//'`; do
    ssh-copy-id -i ~/.ssh/id_rsa.pub pi@$host
done
