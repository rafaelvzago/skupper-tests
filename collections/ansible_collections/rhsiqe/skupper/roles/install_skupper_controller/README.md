# Role: install_skupper_controller

This Ansible role deploys the Skupper Controller to a Kubernetes cluster. The controller manifest is downloaded from a specified URL and applied to the cluster using the provided kubeconfig.

## Tasks

- **Install Skupper Controller:**
  - Applies the Skupper Controller manifest to the Kubernetes cluster, ensuring the deployment of Skupper is initiated.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

- **Defaults:**
  - `install_skupper_controller_skupper_controller_manifest`: URL of the Skupper Controller manifest file. The default value points to a cluster-scoped manifest hosted in the Skupper project's repository:
    ```yaml
    install_skupper_controller_skupper_controller_manifest: 'https://raw.githubusercontent.com/skupperproject/skupper/v2/cmd/controller/deploy_cluster_scope.yaml'
    ```
- **Inventory Variables:**
  - `kubeconfig`: Path to the kubeconfig file for connecting to the target Kubernetes cluster. This variable must be set in the inventory.

## Example Usage

Define the required variables in your inventory, and include the role in your playbook:

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Install the Skupper Controller
      ansible.builtin.include_role:
        name: rhsiqe.skupper.install_skupper_controller
```

### Inventory (host_vars)

```yaml
# host_vars for target host
kubeconfig: /path/to/your/kubeconfig
```

## Notes

- This role uses the `kubernetes.core.k8s` module to interact directly with the Kubernetes API. Ensure the `kubernetes.core` collection is installed and configured correctly.
- The `install_skupper_controller_skupper_controller_manifest` variable can be overridden if you want to use a different version or a custom manifest.
- The `skupper_controller_results` variable stores the outcome of the deployment task for further inspection or debugging.

## License

This project is licensed under the Apache License 2.0.