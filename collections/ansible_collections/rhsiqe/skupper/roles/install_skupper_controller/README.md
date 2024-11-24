# Role: install_skupper_controller

This Ansible role installs the Skupper Controller in a Kubernetes cluster by applying a pre-defined manifest file. The controller is a critical component for managing Skupper resources in a cluster.

## Tasks

- **Install Skupper Controller:**
  - Uses the `kubernetes.core.k8s` module to apply the controller manifest to the Kubernetes cluster.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

| Variable                                           | Default Value                                                                                 | Description                                                              |
|----------------------------------------------------|-----------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| `install_skupper_controller_skupper_controller_manifest` | `https://raw.githubusercontent.com/skupperproject/skupper/v2/cmd/controller/deploy_cluster_scope.yaml` | URL of the Skupper Controller manifest file to be applied.              |
| `kubeconfig`                                       |                                                                                               | Path to the kubeconfig file for accessing the Kubernetes cluster. **Mandatory.** |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Install the Skupper Controller
      ansible.builtin.include_role:
        name: rhsiqe.skupper.install_skupper_controller
```

### Inventory (host_vars)

#### `east.yml`

```yaml
kubeconfig: /path/to/east/kubeconfig
```

#### `west.yml`

```yaml
kubeconfig: /path/to/west/kubeconfig
```

## Notes

- The controller manifest is applied as-is from the provided URL. Ensure that the URL points to a valid and compatible version of the Skupper Controller manifest.
- The `failed_when` directive is set to `false` to prevent role failure in case the manifest is already applied or does not require changes.
- The role uses the `kubernetes.core.k8s` module, which requires the `kubernetes.core` collection to be installed.

## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.