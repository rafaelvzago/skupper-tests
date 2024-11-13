# Skupper Tests Ansible Project

## Project Structure and Content

This project directory is structured according to best practices recommended by the Ansible community. The following structure provides a clear separation of roles, playbooks, collections, and inventory, allowing for easy customization and scalability.

```plaintext
skupper-tests-playbook/
|── .devcontainer/
|── .github/
|   └── workflows/
|       └── tests.yml
|── .vscode/
|── collections/
|   └── ansible_collections/
|       └── rhsiqe/
|           └── skupper/
|               └── roles/
|                   └── env_shakeout/
|                       └── tasks/
|                           └── main.yml
|                       └── defaults/
|               └── README.md
|               └── galaxy.yml
|── scenarios/
|   └── hello-world/
|       └── inventory/
|           └── group_vars/
|               └── all.yml
|           └── host_vars/
|               └── east.yml
|               └── west.yml
|           └── hosts.yml
|       └── hello-world.yml
|── venv/
|── .gitignore
|── ansible.cfg
|── ansible-navigator.yml
|── devfile.yaml
|── Makefile
|── README.md
|── requirements.yml
|── requirements.txt
```

## Key Files and Directories

- **collections/requirements.yml**: Lists the Ansible collections required by this project, including versions for compatibility.
- **scenarios/hello-world/**: Example scenario directory containing `inventory` and `hello-world.yml` playbook.
- **roles/**: Modular roles under `ansible_collections/rhsiqe/skupper/roles`, structured for reusability.
- **venv/**: Virtual environment for managing dependencies.
- **ansible.cfg**: Ansible configuration file customized for this project.
- **requirements.yml**: Specifies the Ansible collections with exact versions, ensuring reproducibility.
- **README.md**: Provides documentation and usage information for the project.
- **Makefile**: Contains automation commands for common tasks.

## Compatibility

This project is tested with ansible-lint >=24.2.0 and is compatible with the latest stable version of ansible-core. 

## Building and installing the project

To build and install the project, follow these steps:

1. Clone the repository and navigate to the project directory.
2. Use the `make` command to install the project dependencies and collections.

```bash
make build
```

# In your project

1. You can now use the collection:

Add the following to your `requirements.yml`:

```yaml
  - name: rhsiqe.skupper
    source: https://github.com/rafaelvzago/skupper-tests.git#collections/ansible_collections/rhsiqe/skupper
    type: git
    version: 0.0.1
```

2. Use the collection in your playbooks:

```yaml
- hosts: localhost
  collections:
    - rhsiqe.skupper
  tasks:
    - name: Run the env_shakeout role
      include_role:
        name: env_shakeout
```

## License

This project is licensed under the Apache License 2.0. For more information, see the [LICENSE](LICENSE) file.
