Here's an updated `README.md` for the `Skupper Tests Ansible Project`, taking into account the more detailed file structure provided.

---

# Skupper Tests Ansible Project

## Project Structure and Content

This project directory is structured according to Ansible best practices, with organized roles, scenarios, and configurations that support modularity, scalability, and reusability. The layout is designed for effective configuration management and comprehensive testing of Skupper environments.

```plaintext
skupper-tests-playbook/
|── ansible.cfg
|── .ansible-lint
|── ansible-navigator.yml
|── collections/
|   └── ansible_collections/
|       └── rhsiqe/
|           └── skupper/
|               ├── galaxy.yml
|               ├── README.md
|               └── roles/
|                   ├── deploy_workload/
|                   │   ├── defaults/
|                   │   │   └── main.yml
|                   │   ├── README.md
|                   │   └── tasks/
|                   │       └── main.yml
|                   ├── env_shakeout/
|                   │   ├── defaults/
|                   │   │   └── main.yml
|                   │   ├── README.md
|                   │   └── tasks/
|                   │       └── main.yml
|                   ├── generate_namespaces/
|                   │   ├── defaults/
|                   │   │   └── main.yml
|                   │   ├── README.md
|                   │   └── tasks/
|                   │       └── main.yml
|                   ├── install_skupper/
|                   │   ├── defaults/
|                   │   │   └── main.yml
|                   │   ├── README.md
|                   │   └── tasks/
|                   │       └── main.yml
|                   └── teardown_namespaces/
|                       ├── defaults/
|                       │   └── main.yml
|                       ├── README.md
|                       └── tasks/
|                           └── main.yml
|── scenarios/
|   └── hello-world/
|       ├── hello-world.bkp.yml
|       ├── hello-world.yml
|       └── inventory/
|           ├── group_vars/
|           │   └── all.yml
|           ├── hosts.yml
|           └── host_vars/
|               ├── east.yml
|               └── west.yml
|── devfile.yaml
|── .gitignore
|── LICENSE
|── Makefile
|── README.md
|── requirements.txt
```

## Key Files and Directories

- **`collections/requirements.yml`**: Specifies required Ansible collections, ensuring compatibility and reproducibility.
- **`scenarios/hello-world/`**: Contains an example scenario with `inventory` and the `hello-world.yml` playbook for deploying and testing a Skupper setup.
- **`roles/`**: Modular roles within `ansible_collections/rhsiqe/skupper/roles`, structured for reusability.
- **`venv/`**: Directory for the Python virtual environment and dependencies.
- **`ansible.cfg`**: Project-specific Ansible configurations.
- **`requirements.yml`**: Lists required Ansible collections with versioning.
- **`Makefile`**: Contains automation scripts for common tasks, simplifying project management.

## Compatibility

This project has been tested with `ansible-lint >= 24.2.0` and is compatible with the latest stable version of `ansible-core`.

## Building and Installing the Project

To build and install the project:

1. Clone the repository and navigate to the project directory.
2. Run `make install` to install dependencies and required collections:

   ```bash
   make install
   ```

## Tagging the Collection Release and Pushing to GitHub

To tag a new release and push to GitHub:

1. Use the `make tag` command to automate the tagging and pushing process:

   ```bash
   make tag
   ```

2. Alternatively, you can manually tag and push:

   ```bash
   git tag -a x.y.z -m "Release x.y.z"
   git push origin x.y.z
   ```

## Using the Collection in Playbooks

To include this collection in other playbooks:

1. Add the collection to your `requirements.yml`:

   ```yaml
   - name: rhsiqe.skupper
     source: https://github.com/rafaelvzago/skupper-tests.git#collections/ansible_collections/rhsiqe/skupper
     type: git
     version: x.y.z
   ```

2. Reference the collection in your playbooks:

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

The **hello-world** scenario showcases a flexible inventory structure for multi-environment configuration. The inventory allows global, group, and host-specific variables.

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

- **`group_vars/all.yml`**: Defines global variables for all hosts in the inventory. Sample configuration:

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

  - `ansible_connection`: Sets the connection type, here as `local` for local testing.
  - `images`: Defines container images for different application components.
  - `kubeconfig`: Specifies the Kubernetes configuration file path.

- **`hosts.yml`**: Lists hosts (`west` and `east`) in the `all` group.

  ```yaml
  ---
  all:
    hosts:
      west:
      east:
  ```

- **`host_vars/east.yml` and `host_vars/west.yml`**: Customize host-specific configurations, such as `kubeconfig` paths or environment variables.

  ```yaml
  # Example for west host configuration
  kubeconfig: /path/to/west/kubeconfig
  ```

This flexible structure allows cluster-specific configurations in `host_vars` while maintaining global settings in `group_vars`, enabling easy expansion for new clusters or environments.

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for more details.

