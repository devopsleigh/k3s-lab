# 1. Flash Raspbian Lite to all SD cards
# 2. Copy wpa_supplicant and SSH to the boot partition
# 3. Get IP addresses of all nodes from router and set static IP
# 4. Configure hosts.ini

# USING WSL

# Install ansible and set inventory
sudo apt install ansible -y
sudo cp hosts.ini /etc/ansible/hosts

# Copy SSH keys to another machine for password-less login
bash copy-ssh-keys.sh

# Configure with Ansible
ansible-playbook baseline.yml -e 'ansible_ssh_user=pi' --extra-vars @secrets.yml

# Install K3S
ansible-playbook kubernetes.yml
