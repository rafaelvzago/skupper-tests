# Role: create_connector

This Ansible role automates the creation and management of `Connector` resources in a Kubernetes cluster using the Skupper API. It generates a manifest for the `Connector` resource based on a template, applies it to the target namespace, and optionally debugs the results.

## Tasks

- **Set Manifest File Path:**
  - Determines the file path for the `Connector` manifest based on the inventory host.
- **Delete Existing Connector Manifest:**
  - Removes any existing manifest file to ensure a clean state.
- **Render Connector Manifest:**
  - Creates a Kubernetes manifest for the `Connector` resource using a Jinja2 template.
- **Apply Manifest to Kubernetes:**
  - Uses the `kubernetes.core.k8s` module to apply the manifest to the specified namespace.
- **Debug Application Results:**
  - Outputs the results of the applied `Connector` resource for verification.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`
- Skupper installed and configured in the target namespaces

## Role Variables

| Variable                           | Default Value                 | Description                                                                 |
|------------------------------------|-------------------------------|-----------------------------------------------------------------------------|
| `create_connector_routing_key`     | `backend`                     | Routing key for the `Connector`.                                            |
| `create_connector_metadata_name`   | `backend`                     | Metadata name for the `Connector`.                                          |
| `create_connector_port`            | `8080`                        | Port for the `Connector`.                                                  |
| `create_connector_selector`        | `app=backend`                 | Selector for the `Connector`.                                              |
| `create_connector_manifest_template` | `connector.yml.j2`           | Jinja2 template for the `Connector` manifest.                              |
| `create_connector_state`           | `present`                     | Desired state of the resource (`present` or `absent`).                      |
| `create_connector_output_path`     | `/tmp/localhost`              | Directory where the manifest file will be stored.                          |
| `namespace_prefix`                 |                               | Prefix for the Kubernetes namespace.                                        |
| `namespace_name`                   |                               | Name of the Kubernetes namespace.                                           |
| `kubeconfig`                       |                               | Path to the kubeconfig file for cluster access.                             |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Expose a backend connector
      ansible.builtin.include_role:
        name: rhsiqe.skupper.create_connector
      vars:
        namespace_prefix: "skupper"
        namespace_name: "east"
        create_connector_routing_key: "frontend"
        create_connector_metadata_name: "frontend-connector"
        create_connector_port: 9090
        create_connector_selector: "app=frontend"
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
- The generated manifest file is stored in the `create_connector_output_path` directory, named according to the inventory host.
- Ensure the `kubernetes.core.k8s` module is installed to use this role.

## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.
