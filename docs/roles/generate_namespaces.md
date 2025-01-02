# Role: generate_namespaces

This Ansible role creates Kubernetes namespaces using a specified prefix and name. It ensures the namespace is created in the target cluster and displays its details for verification.

## Tasks

- **Create Namespace:**
  - Uses the `kubernetes.core.k8s` module to create a Kubernetes namespace with the specified name.
- **Display Namespace Details:**
  - Outputs the name of the created namespace for confirmation.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

| Variable           | Description                                                                     |
|--------------------|---------------------------------------------------------------------------------|
| `namespace_prefix` | Prefix for the namespace.                                                      |
| `namespace_name`   | Base name for the namespace.                                                   |
| `kubeconfig`       | Path to the kubeconfig file for accessing the cluster. **Mandatory.**          |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Generate namespaces
      ansible.builtin.include_role:
        name: rhsiqe.skupper.generate_namespaces
      vars:
        namespace_prefix: "skupper"
        namespace_name: "east"
```

### Inventory (host_vars)

#### `east.yml`

```yaml
kubeconfig: /path/to/east/kubeconfig
namespace_prefix: "skupper"
namespace_name: "east"
```

#### `west.yml`

```yaml
kubeconfig: /path/to/west/kubeconfig
namespace_prefix: "skupper"
namespace_name: "west"
```

## Notes

- The namespace is created as `<namespace_prefix>-<namespace_name>`.
- Ensure the `kubernetes.core.k8s` module is installed to use this role.
- The task outputs the namespace details for verification.

## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.