# Configure EOS for testing

## Requirements

```bash
pip install ansible
ansible-galaxy collection install -f arista.avd
```

## Configuration Management

### Location

```bash
cd atd-inventory/
```

### Inventory

  - Inventory file: [atd-inventory/inventory.yml](../atd-inventory/inventory.yml)
  - AVD variables: [atd-inventory/group_vars](../atd-inventory/group_vars)

### Commands

- Build only

```bash
ansible-playbook playbooks/atd-fabric-deploy.yml --tags build
```
