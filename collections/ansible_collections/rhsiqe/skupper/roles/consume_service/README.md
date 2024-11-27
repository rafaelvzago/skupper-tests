# Role: consume_service

This Ansible role automates the creation and management of `Listener` resources in a Kubernetes cluster using the Skupper API. It generates a manifest for the `Listener` resource from a template, applies it to the target namespace, and verifies the results.

## Tasks

- **Generate Listener Manifest:**
  - Creates a Kubernetes manifest for the `Listener` resource using a Jinja2 template.
- **Apply Manifest to Kubernetes Cluster:**
  - Uses the `kubernetes.core.k8s` module to apply the manifest in the specified namespace.
- **Debug Applied Results:**
  - Outputs the results of the applied Listener for verification.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`
- Skupper installed and configured in the target namespaces

## Role Variables

| Variable                             | Default Value                 | Description                                                                 |
|--------------------------------------|-------------------------------|-----------------------------------------------------------------------------|
| `consume_service_metadata_name`      | `backend`                     | Name of the `Listener` resource.                                            |
| `consume_service_routing_key`        | `backend`                     | Routing key for the `Listener`.                                             |
| `consume_service_port`               | `8080`                        | Port on which the service listens.                                          |
| `consume_service_host`               | `backend`                     | Hostname or service backend.                                                |
| `consume_service_manifest_template`  | `listener.yml.j2`             | Jinja2 template for generating the `Listener` manifest.                     |
| `consume_service_state`              | `present`                     | Desired state of the `Listener` resource (`present` or `absent`).           |
| `consume_service_output_path`        | `/tmp/localhost`              | Directory where the generated manifest files are stored.                    |
| `namespace_prefix`                   |                               | Prefix for the Kubernetes namespace.                                        |
| `namespace_name`                     |                               | Name of the Kubernetes namespace.                                           |
| `kubeconfig`                         |                               | Path to the kubeconfig file for cluster access.                             |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Include the consume_service role
      ansible.builtin.include_role:
        name: rhsiqe.skupper.consume_service
      vars:
        namespace_prefix: "skupper"
        namespace_name: "east"
        consume_service_metadata_name: "frontend"
        consume_service_routing_key: "frontend"
        consume_service_port: 9090
        consume_service_host: "frontend-service"
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

- The namespace is derived as `<namespace_prefix>-<namespace_name>`.
- Generated manifests are stored in the `consume_service_output_path` directory, named according to the inventory host.
- Ensure the `kubernetes.core` collection is installed to use the `kubernetes.core.k8s` module.

## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.