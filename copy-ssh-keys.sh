#!/bin/bash
for ip in `ansible k3s-cluster --list-hosts | grep 10. | sed -e 's/^[ \t]*//'`; do
    ssh-copy-id -i ~/.ssh/id_rsa.pub pi@$ip
done
