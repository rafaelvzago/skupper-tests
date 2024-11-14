Here’s a `README.md` for the `install_skupper` role based on the details you provided:

---

# Install Skupper Ansible Role

This Ansible role automates the installation of Skupper by cloning the Skupper repository, applying required CRDs, and deploying the Skupper controller. It also includes tasks to clean up the temporary files after the installation is complete. This role supports customization through various variables to define the Skupper version, repository, controller manifest, and Helm settings.

## Default Variables

The following variables in `defaults/main.yml` define the default configurations used by this role. You can override these in your inventory or playbook to customize the installation.

- **`install_skupper_skupper_repository`**: URL of the Skupper Git repository.
  - Default: `'https://github.com/skupperproject/skupper.git'`
- **`install_skupper_skupper_branch`**: Branch to be checked out in the Skupper repository.
  - Default: `'v2'`
- **`install_skupper_skupper_controller_manifest`**: URL to the Skupper controller manifest.
  - Default: `'https://raw.githubusercontent.com/skupperproject/skupper/v2/cmd/controller/deploy_cluster_scope.yaml'`
- **`install_skupper_skupper_release_name`**: Name for the Helm release.
  - Default: `skupper-setup`
- **`install_skupper_helm_install_scope`**: Scope setting for the Helm installation (`cluster` or `namespace`).
  - Default: `cluster`

## Role Tasks

This role performs the following tasks to install Skupper:

1. **Ensure Helm is Installed**:
   - Installs Helm on the control node if it is not already installed.

2. **Clean Temporary Directory**:
   - Deletes any existing `/tmp/skupper` directory to ensure a clean setup.

3. **Clone Skupper Repository**:
   - Clones the specified branch of the Skupper repository to `/tmp/skupper`.

4. **Install Skupper by Applying CRDs**:
   - Applies Custom Resource Definitions (CRDs) from the Skupper repository using the `kubernetes.core.k8s` module.

5. **Install the Skupper Controller**:
   - Applies the Skupper controller manifest to the cluster, deploying the Skupper controller.

6. **Clean Up**:
   - Deletes the cloned Skupper repository directory after installation.

## Example Playbook

Here is an example playbook that calls the `install_skupper` role, with conditions to run it only on the `west` host and if `skip_skupper_install` is not set to `true`.

```yaml
---
- name: Hello World test playbook
  hosts: all
  tasks:
    - name: Installing Skupper
      ansible.builtin.include_role:
        name: rhsiqe.skupper.install_skupper
      when:
        - "'west' in inventory_hostname"
        - not skip_skupper_install | default(false) | bool
```

In this example:
- **Condition**: The Skupper installation is limited to hosts named `west` and will only run if `skip_skupper_install` is `false` or unset.

## Variables to Set in Inventory

Each host should define the path to its `kubeconfig` file, which is required by the role for Kubernetes cluster access.

```yaml
# host_vars/west.yml
kubeconfig: /path/to/west/kubeconfig
```

## Customizing the Role

You can customize the role by overriding the default variables in `host_vars`, `group_vars`, or directly in the playbook.

Example override in `host_vars`:

```yaml
# host_vars/west.yml
install_skupper_skupper_branch: 'v2.1'
install_skupper_skupper_release_name: 'custom-skupper'
install_skupper_helm_install_scope: 'namespace'
kubeconfig: /path/to/west/kubeconfig
```

## Requirements

- Ansible 2.9 or newer
- Helm installed on the control node
- Access to a Kubernetes cluster with proper permissions

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for more details.

---

This `README.md` covers the purpose of the role, variables, tasks, an example playbook, and customization options, making it easy to understand and use the `install_skupper` role.