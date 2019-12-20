# 1. Flash Raspbian Lite to all SD cards
# 2. Copy wpa_supplicant and SSH to the boot partition
# 3. Get IP addresses of all nodes from router and set static IP

###### Debian WSL

# install ansible and set inventory
sudo apt install ansible -y
sudo cp hosts.ini /etc/ansible/hosts

# Copy SSH keys to another machine for password-less login
# ssh-keygen -t rsa
bash copy-ssh-keys.sh

ansible-playbook baseline.yml
