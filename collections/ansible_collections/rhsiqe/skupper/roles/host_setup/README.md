# Role: host_setup

This Ansible role installs `helm` on target hosts to prepare them for managing Kubernetes deployments. The role ensures that the Helm package is installed and up to date.

## Tasks

- **Install Helm:**
  - Installs the `helm` package using the default package manager of the target host.
  - Ensures that `helm` is present and updated.
  - Installs the package using the script when the package is not available in the default package manager.

## Requirements

- Ansible 2.9 or newer
- Elevated privileges (e.g., `become: true`) on the target hosts to install packages.
- The target hosts must support the installation of `helm` via their default package manager.

## Role Variables

This role does not require any additional variables to function. It uses default settings to install the `helm` package. However, you can customize it if needed by overriding variables related to package management.

## Example Usage

Include the role in your playbook to install `helm` on target hosts:

### Playbook

```yaml
- hosts: all
  become: true
  tasks:
    - name: Set up the host with helm
      ansible.builtin.include_role:
        name: rhsiqe.skupper.host_setup
```

### Inventory

Ensure that the target hosts are correctly defined in the inventory:

#### `inventory/hosts.yml`

```yaml
all:
  hosts:
    target_host_1:
      ansible_host: 192.168.1.100
    target_host_2:
      ansible_host: 192.168.1.101
```

#### `inventory/group_vars/all.yml`

```yaml
ansible_user: your_user
ansible_ssh_private_key_file: /path/to/ssh/key
```

## Notes

- The role uses the `ansible.builtin.package` module for installing `helm`, which ensures compatibility with the package manager of the target operating system.
- If you require specific Helm versions or additional configurations, you can extend this role or override variables in your playbook or inventory.
- Test this role using the included `tests/test_playbook.yml` to verify functionality before deploying to production.

## License

Apache License 2.0
