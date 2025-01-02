# Role: env_shakeout

This Ansible role performs a shakeout test for a Kubernetes environment. It verifies cluster connectivity and optionally debugs the inventory variables for each host.

## Tasks

- **Debug Host Variables:**
  - Outputs all host variables for the current inventory host when debugging is enabled.
- **Verify Cluster Connection:**
  - Checks the connection to the Kubernetes cluster by listing nodes.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

| Variable              | Default Value | Description                                                         |
|-----------------------|---------------|---------------------------------------------------------------------|
| `env_shakeout_debug`  | `false`       | Whether to debug and output all inventory variables for the host.   |
| `kubeconfig`          |               | Path to the kubeconfig file for accessing the cluster. **Mandatory.** |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Perform an environment shakeout test
      ansible.builtin.include_role:
        name: rhsiqe.skupper.env_shakeout
      vars:
        env_shakeout_debug: true
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

- If `env_shakeout_debug` is set to `true`, all inventory variables for the current host will be displayed.
- The role uses the `kubernetes.core.k8s_info` module to list cluster nodes, confirming connectivity to the Kubernetes API.

## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.