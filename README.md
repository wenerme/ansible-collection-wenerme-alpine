# Ansible Collection - wenerme.alpine

A collection of tasks for managing AlpineLinux

- [wenerme.alpine](https://galaxy.ansible.com/wenerme/alpine) on galaxy

```bash
ansible-galaxy collection install wenerme.alpine
```

- alpine
  - setup
  - upgrade
- apk
- consul
- dnsmasq
- docker
- frpc
- frps
- haproxy
- k0s
- k3s
- n2n
- nextcloud
- ntp
- pdns - PowerDNS
- prometheus
- tinc
- zerotier
- zfs
- [ ] aports

## Setup

```bash
inv_name=wener
export ANSIBLE_INVENTORY=$PWD/$inv_name/inventory

# adhoc alias make life easier
echo '- import_playbook: wenerme.alpine.adhoc' > adhoc.yaml
adhoc(){ local task=$1;shift; ansible-playbook $PWD/adhoc.yaml -e task=$task $*; }

# basic setup for alpine linux
# root -> admin
# same as:
# adhoc setup-base
# adhoc setup-base-service
# adhoc hostname
echo '- import_playbook: wenerme.alpine.setup' > setup.yaml
ansible-playbook setup.yaml -e ansible_user=root

# install tools for ops
adhoc setup-ops
```

## Common Operations

```bash
# ansible-playbook inv-keygen.yaml
# ssh-add $inv_name/credentials/admin_rsa

# ansible-playbook inv-ssh-copy-id.yaml -e remote_user=root -k
# ssh-copy-id ROOT for initial setup
ssh-copy-id -i $inv_name/credentials/admin_rsa.pub -o PreferredAuthentications=password -o PubkeyAuthentication=no root@192.168.1.1

# do as you need
# adhoc resizefs
# adhoc root-password
# adhoc host-info

# k3s install
adhoc k3s-install
adhoc k3s-prepare
# changed kernel param better to reboot
adhoc reboot

# Join VPN for cross node network
# 1. Tinc VPN
# adhoc tinc-init
# adhoc tinc-supervise
# 2. N2N VPN
# adhoc n2n-service

# start k3s
adhoc k3s-service
# pull k3s
adhoc k3s-fetch-kubeconfig
```

## Convention

- Service life cycle tasks
  - `<SERVICE>-service`
    - `<SERVICE>-install`
    - `<SERVICE>-conf`
  - `<SERVICE>-upgrade`
  - `<SERVICE>-stop`
  - `<SERVICE>-uninstall`
- Notify
  - `<SERVICE>.<ACTION>`
    - Action - reload, restart
- Inventory values
  - `inv_name` - inventory name
  - `Values` - load local values
- Inventory structure
  - `/<inv_name>/`
    - `values.yaml`
    - `inventory/`
      - `all.yaml`
    - `host/` - Host base configs
      - `etc/`
    - `<inventory_hostname>/`
      - `backup/`
      - `etc/` - Host config

**all.yaml**

```yaml
all:
  vars:
    inv_name: "wener"
    # Load local Values
    Values: "{{ lookup('file', inv_name+'/values.yaml') | from_yaml }}"
```

## See also

- [linux-system-roles/kernel_settings](https://github.com/linux-system-roles/kernel_settings)
