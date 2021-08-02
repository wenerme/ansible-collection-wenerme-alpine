# Ansible Collection - wenerme.alpine

A collection of tasks for managning AlpineLinux

- [wenerme.alpine](https://galaxy.ansible.com/wenerme/alpine) on galaxy

```bash
ansible-galaxy collection install wenerme.alpine
```

- apk
- consul
- docker
- haproxy
- k3s
- nextcloud
- pdns - PowerDNS
- prometheus
- setup
- tinc
- zerotier
- zfs
- n2n

# Support Multi Inventory Structure

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
