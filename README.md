# Ansible Collection - wenerme.alpine

A collection of tasks for managning AlpineLinux

- [wenerme.alpine](https://galaxy.ansible.com/wenerme/alpine) on galaxy

```bash
ansible-galaxy collection install wenerme.alpine
```

- apk
- consul
- dnsmasq
- docker
- haproxy
- k0s
- k3s
- n2n
- nextcloud
- ntp
- pdns - PowerDNS
- prometheus
- setup
- tinc
- zerotier
- zfs

## Support Multi Inventory Structure

- inv_name - inventory name
- values.yaml - private local conf
- all.yaml - inventory level conf

```
/<inventory-name>
  /values.yaml
  /inventory
    /all.yaml
  /files
    /<service>.conf
    /<hostname>
      /<per-host>.conf
  /credentials
    /<op_rsa>
    /<op_rsa>.pub
```

**all.yaml**

```yaml
all:
  vars:
    inv_name: "wener"
    # Load local Values
    Values: "{{ lookup('file', inv_name+'/values.yaml') | from_yaml }}"
```

```bash
export ANSIBLE_INVENTORY=$PWD/<inv_name>/inventory
```

## Common Operations

```bash
inv=wener
export ANSIBLE_INVENTORY=$PWD/$inv/inventory

# ansible-playbook inv-keygen.yaml
# ssh-add $inv/credentials/admin_rsa

# ansible-playbook inv-ssh-copy-id.yaml -e remote_user=root -k
# ssh-copy-id ROOT for initial setup
ssh-copy-id -i $inv/credentials/admin_rsa.pub -o PreferredAuthentications=password -o PubkeyAuthentication=no root@192.168.1.1

# alias
adhoc(){ local task=$1;shift; ansible-playbook $PWD/adhoc.yaml -e task=$task $*; }

# basic setup
adhoc setup-base -e ansible_user=root
adhoc setup-base-service
adhoc setup-ops
adhoc hostname

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

## Seealso

- [linux-system-roles/kernel_settings](https://github.com/linux-system-roles/kernel_settings)
