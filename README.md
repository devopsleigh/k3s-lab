# Raspberry Pi K3S Lab

Configures a multi-board Raspberry Pi lab using Ansible.

## Prerequisites

- WSL terminal (tested with Debian)

## Installation

1. Download the repository

   ```sh
   git clone https://github.com/devopsleigh/k3s-lab.git
   cd k3s-lab
   ```

2. Edit the Ansible inventory

   ```sh
   nano hosts.ini
   ```

   ```ini
   [someotherserver]
   10.0.0.2 ansible_user=user

   [master]
   10.0.0.10

   [node]
   10.0.0.[11:13]

   [k3s-cluster:children]
   master
   node

   [k3s-cluster:vars]
   ansible_user=pi
   ```

3. Edit the secrets file:

   ```sh
   nano secrets.yml
   ```

   ```yml
   ---
   TZ=Country/City
   ```

4. Run the configuration script:

   ```sh
   sudo bash config.sh
   ```
