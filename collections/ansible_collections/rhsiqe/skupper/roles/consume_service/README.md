# Role: consume_service

The `consume_service` Ansible role creates and manages a Skupper `Listener` resource to enable services to consume messages using a specified configuration. It uses a Jinja2 template to generate the Listener manifest and applies it to the Kubernetes cluster.

## Tasks

- **Set Manifest Path:**
  - Configures the file path for the Listener manifest and determines the namespace for deployment.
- **Delete Existing Manifest:**
  - Ensures any pre-existing Listener manifest file is removed.
- **Render Listener Manifest:**
  - Generates a Listener manifest from the provided Jinja2 template with role variables.
- **Apply Manifest:**
  - Applies the generated manifest to the Kubernetes cluster.
- **Debug Results:**
  - Outputs details of the applied Listener resource for debugging purposes.

## Requirements

- Ansible 2.9 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`
- Skupper operator installed and running in the target namespace

## Role Variables

### Default Variables
The following variables can be overridden in your playbooks or inventory:

| Variable                       | Default Value         | Description                                        |
|--------------------------------|-----------------------|----------------------------------------------------|
| `consume_service_metadata_name` | `backend`             | Metadata name for the Listener resource.           |
| `consume_service_routing_key`   | `backend`             | Routing key for the Listener.                      |
| `consume_service_port`          | `8080`               | Port for the Listener to bind to.                  |
| `consume_service_host`          | `backend`            | Host address for the Listener.                     |
| `consume_service_manifest_template` | `listener.yml.j2` | Template for rendering the Listener manifest.      |
| `consume_service_state`         | `present`            | Desired state of the Listener resource (`present` or `absent`). |

### Inventory Variables
These variables should be set at the inventory level:

| Variable         | Description                                          |
|------------------|------------------------------------------------------|
| `namespace_prefix` | Prefix for the namespace where the Listener is deployed. |
| `namespace_name`   | Base name for the namespace.                       |
| `kubeconfig`       | Path to the kubeconfig file for cluster access.    |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Include consume_service role
      ansible.builtin.include_role:
        name: rhsiqe.skupper.consume_service
      vars:
        consume_service_metadata_name: "custom-backend"
        consume_service_routing_key: "custom-key"
        consume_service_port: 9090
```

### Inventory (host_vars)

```yaml
# host_vars for target host
namespace_prefix: "demo"
namespace_name: "app"
kubeconfig: "/path/to/kubeconfig"
```

### Rendered Listener Manifest (Example)

```yaml
apiVersion: skupper.io/v2alpha1
kind: Listener
metadata:
  name: custom-backend
spec:
  routingKey: custom-key
  port: 9090
  host: backend
```

## Notes

- The namespace for the Listener is constructed as `<namespace_prefix>-<namespace_name>`.
- Ensure the Skupper operator is installed and functional in the target namespace.
- The `kubernetes.core.k8s` module is used to manage the Listener resource declaratively.

## License

Apache License, Version 2.0
