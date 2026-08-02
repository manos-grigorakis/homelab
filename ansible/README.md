# Ansible

> Note: Execute commands from `/ansible` directory

## Setup

1. Create Python virtual environment

   ```bash
   python -m venv .venv
   ```

2. Activate virtual environment

   ```bash
   source .venv/bin/activate
   ```

3. Install dependencies

   ```bash
   python install -r requirements-lock.txt
   ```

4. Install Ansible collections

   ```bash
   ansible-galaxy collection install -r requirements.yml
   ```

## HashiCorp Vault

Configure `ansible.cfg` for Vault URL and authentication method. Then export variables to shell.

```bash
export ANSIBLE_HASHI_VAULT_ROLE_ID="<role_id>"
export ANSIBLE_HASHI_VAULT_SECRET_ID="<secret_id>"
```

## Inventory

### List Inventory

```bash
ansible-inventory -i inventory/<file_name_inventory.yaml> --graph
```

### Verify Inventory & SSH Connectivity

- Verify Whole Inventory

  ```bash
  ansible -i inventory/<file_name_inventory.yaml> all -m ping
  ```

- Verify Specific Host

  ```bash
  ansible -i inventory/<file_name_inventory.yaml> <host-name> -m ping
  ```

## Run Playbooks

- ### Run Playbook with sudo (become)

  > When playbooks require become, you will be prompted for the sudo (become) password.

  ```bash
  ansible-playbook -i inventory/<file_name_inventory.yaml> \
  playbooks/<file_name_playbook.yaml> \
  -K
  ```

- ### Run Playbook (default target)

  ```bash
  ansible-playbook -i inventory/<file_name_inventory.yaml> \
  playbooks/<file_name_playbook.yaml>
  ```

- ### Run Playbook Using `target` Variable

  Playbook must have:
  - Variable with fallback: `hosts: "{{ target | default('<fallback_group_name>') }}"`

  ```bash
  ansible-playbook -i inventory/<file_name_inventory.yaml> \
  playbooks/<file_name_playbook.yaml> \
  -e "target=<host-name>"
  ```

- ### Run Playbook For Specific Host Only
  ```bash
  ansible-playbook -i inventory/<file_name_inventory.yaml> \
  playbooks/<file_name_playbook.yaml> --limit <host-name>
  ```

## NetBox (v4.6.5 Docker)

### Token

Write enabled = False

### Permissions

Read-only

| App            | Object Type         |
| -------------- | ------------------- |
| DCIM           | Manufacturer        |
| DCIM           | Device Role         |
| DCIM           | Platform            |
| DCIM           | Device              |
| DCIM           | Device Type         |
| DCIM           | Rack                |
| DCIM           | Region              |
| DCIM           | Site Group          |
| DCIM           | Site                |
| DCIM           | Location            |
| Extras         | Tag                 |
| IPAM           | IP Address          |
| IPAM           | Application Service |
| Tenancy        | Tenant              |
| Virtualization | Cluster             |
| Virtualization | Virtual Machine     |
