
# Role: generate_namespaces

This Ansible role creates a Kubernetes namespace using a specified prefix and namespace name. The prefix is defined when calling the role, and the namespace name is specified in the inventory. The role outputs the created namespace details for verification.

## Tasks

- **Create Namespace:**
  - Creates a Kubernetes namespace using the specified prefix and namespace name.
- **Display Namespace Details:**
  - Outputs the details of the created namespace.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

- **Role Variables:**
  - `generate_namespaces_prefix`: Specifies the prefix for the namespace. This is passed directly when including the role.
- **Inventory Variables:**
  - `generate_namespaces_namespace_name`: Specifies the base name for the namespace (e.g., `hello-world-east` or `hello-world-west`). This should be defined in the inventory at the host level.
  - `kubeconfig`: Specifies the path to the kubeconfig file for connecting to the cluster. This should also be set in the inventory.

## Example Usage

Define the prefix when calling the role in your playbook, and specify the namespace name in the inventory:

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Calling the role to generate the namespaces
      ansible.builtin.include_role:
        name: rhsiqe.skupper.generate_namespaces
      vars:
        generate_namespaces_prefix: zago
```

### Inventory (host_vars)

```yaml
# host_vars for target host
kubeconfig: /path/to/east/kubeconfig
generate_namespaces_namespace_name: hello-world-east
```

## Notes

- The namespaces created will be in the format: `<prefix>-<namespace_name>`, combining `generate_namespaces_prefix` and `generate_namespaces_namespace_name`.
- Ensure that `kubeconfig` and `generate_namespaces_namespace_name` are defined at the inventory level for each target host.
- This role uses the `kubernetes.core.k8s` module to create and manage Kubernetes resources directly, which provides a more reliable and declarative approach than shell commands like `kubectl`.