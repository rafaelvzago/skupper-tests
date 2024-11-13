# Skupper Tests Ansible Project

## Project Structure and Content

This project directory follows best practices recommended by the Ansible community, with a well-organized structure that facilitates role reuse, scenario management, and collection-based development. The layout promotes clarity, customization, and scalability, essential for effective configuration management and testing.

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

- **`collections/requirements.yml`**: Lists Ansible collections essential for the project, ensuring compatible versions.
- **`scenarios/hello-world/`**: Provides a sample scenario with `inventory` and the `hello-world.yml` playbook.
- **`roles/`**: Houses modular roles, located under `ansible_collections/rhsiqe/skupper/roles`, structured for reuse.
- **`venv/`**: Virtual environment for dependency management.
- **`ansible.cfg`**: Configures Ansible settings tailored to this project.
- **`requirements.yml`**: Defines required Ansible collections with precise versions for reproducibility.
- **`README.md`**: Documentation for project usage.
- **`Makefile`**: Automates common tasks for streamlined project management.

## Compatibility

This project has been tested with `ansible-lint >= 24.2.0` and is compatible with the latest stable version of `ansible-core`.

## Building and Installing the Project

To build and install the project, execute the following steps:

1. Clone the repository and navigate to the project directory.
2. Use the `make` command to install dependencies and collections:

    ```bash
    git tag -a x.y.z -m "Release x.y.z"
    git push origin x.y.z
    ```

## Tagging the Collection Release and Pushing to GitHub

Whenever changes are made to the collection, tag the release and push to GitHub:

1. Run the `make` command to tag and push the release:

    ```bash
    make tag
    ```

## Using the Collection in Playbooks

To include this collection in other playbooks, follow these steps:

1. Add the following entry to your `requirements.yml`:

    ```yaml
    - name: rhsiqe.skupper
      source: https://github.com/rafaelvzago/skupper-tests.git#collections/ansible_collections/rhsiqe/skupper
      type: git
      version: x.y.z
    ```

2. Reference the collection in playbooks as follows:

    ```yaml
    - hosts: localhost
      collections:
        - rhsiqe.skupper
      tasks:
        - name: Run the env_shakeout role
          include_role:
            name: env_shakeout
    ```

## Inventory Structure Explanation

The **hello-world** scenario includes a robust and flexible inventory structure that enables configuration of multiple environments. Key files in the inventory demonstrate the flexibility of configuring hosts, group variables, and specific host variables.

### `hello-world/hello-world.yml`

This playbook calls the `env_shakeout` role, which checks the environment readiness.

```yaml
---
- name: Hello World test playbook
  hosts: all
  tasks:
    - name: Calling the role to check the environment
      ansible.builtin.include_role:
        name: rhsiqe.skupper.env_shakeout
```

### Inventory File Structure

- **`group_vars/all.yml`**: Defines global variables applied to all hosts in the inventory. Example configuration:

    ```yaml
    ansible_connection: local
    ansible_user: rzago
    images:
      backend: quay.io/skupper/hello-world-backend
      curl-image: quay.io/rzago/curl-telnet
      frontend: quay.io/skupper/hello-world-frontend
    kubeconfig: /home/rzago/.kube/ocp-minikube
    debug: false
    ```

    - `ansible_connection`: Defines connection type, set to `local` for localhost execution.
    - `images`: Points to Docker images for various components (backend, frontend, and curl-image).
    - `kubeconfig`: Specifies the Kubernetes configuration file path for cluster access.

- **`hosts.yml`**: Lists hosts `east` and `west`, organized under the `all` group for broader targeting.

    ```yaml
    ---
    all:
      hosts:
        west:
        east:
    ```

- **`host_vars/east.yml` and `host_vars/west.yml`**: Customize configuration per host, such as specific kubeconfig paths.

    ```yaml
    # Example placeholder for host-specific kubeconfig path
    kubeconfig: /path/to/west/kubeconfig
    ```

This configuration provides flexibility to set cluster-specific details under `host_vars` while maintaining global settings in `group_vars`. This setup allows for seamless addition of new clusters or environments, enabling dynamic adaptation for various deployments.

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.