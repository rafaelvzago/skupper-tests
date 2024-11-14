Here's an updated README file for your `Skupper Tests Ansible Project` based on the new structure:

---

# Skupper Tests Ansible Project

## Project Structure and Content

This project directory is structured following best practices recommended by the Ansible community. It includes organized roles, scenarios, and configurations to facilitate modularity, scalability, and reuse. This layout supports efficient configuration management and comprehensive testing of Skupper environments.

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
|               ├── roles/
|               │   ├── deploy_workload/
|               │   ├── env_shakeout/
|               │   ├── generate_namespaces/
|               │   └── teardown_namespaces/
|               ├── README.md
|               └── galaxy.yml
|── scenarios/
|   └── hello-world/
|       └── inventory/
|           ├── group_vars/
|           │   └── all.yml
|           ├── host_vars/
|           │   ├── east.yml
|           │   └── west.yml
|           └── hosts.yml
|       └── hello-world.yml
|── venv/
|── ansible.cfg
|── ansible-navigator.yml
|── devfile.yaml
|── Makefile
|── README.md
|── requirements.yml
|── requirements.txt
```

## Key Files and Directories

- **`collections/requirements.yml`**: Specifies required Ansible collections, ensuring version compatibility.
- **`scenarios/hello-world/`**: Contains the sample scenario with `inventory` and the `hello-world.yml` playbook.
- **`roles/`**: Includes modular roles under `ansible_collections/rhsiqe/skupper/roles`, designed for reuse.
- **`venv/`**: Directory for the Python virtual environment and dependencies.
- **`ansible.cfg`**: Configures Ansible settings specific to this project.
- **`requirements.yml`**: Defines required Ansible collections with versioning for reproducibility.
- **`Makefile`**: Automates common tasks, enhancing ease of project management.

## Compatibility

This project has been tested with `ansible-lint >= 24.2.0` and is compatible with the latest stable version of `ansible-core`.

## Building and Installing the Project

To build and install the project:

1. Clone the repository and navigate to the project directory.
2. Use the `make` command to install dependencies and collections:

   ```bash
   make install
   ```

## Tagging the Collection Release and Pushing to GitHub

To tag a new release and push to GitHub:

1. Use the `make` command to tag and push:

   ```bash
   make tag
   ```

2. Alternatively, manually tag and push with:

   ```bash
   git tag -a x.y.z -m "Release x.y.z"
   git push origin x.y.z
   ```

## Using the Collection in Playbooks

To include this collection in other playbooks:

1. Add it to your `requirements.yml`:

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
       - name: Deploy the application
         include_role:
           name: deploy_workload
   ```

## Inventory Structure Explanation

The **hello-world** scenario showcases a flexible inventory structure that allows for multiple environment configurations. Key files in the inventory facilitate customization of global, group, and host-specific variables.

### `hello-world/hello-world.yml`

This playbook calls the `env_shakeout` and `deploy_workload` roles to verify environment readiness and deploy the application.

```yaml
---
- name: Hello World test playbook
  hosts: all
  tasks:
    - name: Checking the environment
      ansible.builtin.include_role:
        name: rhsiqe.skupper.env_shakeout
    - name: Deploying the application
      ansible.builtin.include_role:
        name: rhsiqe.skupper.deploy_workload
```

### Inventory File Structure

- **`group_vars/all.yml`**: Sets global variables for all hosts in the inventory. Sample configuration:

  ```yaml
  ansible_connection: local
  ansible_user: rzago
  images:
    backend: quay.io/skupper/hello-world-backend
    curl_image: quay.io/rzago/curl-telnet
    frontend: quay.io/skupper/hello-world-frontend
  kubeconfig: /home/rzago/.kube/ocp-minikube
  debug: false
  ```

  - `ansible_connection`: Specifies connection type, set to `local` for localhost testing.
  - `images`: Points to container images for various application components.
  - `kubeconfig`: Specifies the path to the Kubernetes configuration file.

- **`hosts.yml`**: Lists hosts under the `all` group, with `west` and `east` as individual entries.

  ```yaml
  ---
  all:
    hosts:
      west:
      east:
  ```

- **`host_vars/east.yml` and `host_vars/west.yml`**: Customize configuration per host, such as kubeconfig paths or environment-specific variables.

  ```yaml
  # Example for west host configuration
  kubeconfig: /path/to/west/kubeconfig
  ```

This inventory structure allows flexible cluster-specific configuration in `host_vars` while maintaining shared settings in `group_vars`. It enables easy expansion for additional clusters or scenarios.

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for more details.