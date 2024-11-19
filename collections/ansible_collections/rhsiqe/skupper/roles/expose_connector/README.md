# Role: expose_connector

This Ansible role manages the creation and deployment of Skupper connectors in a Kubernetes cluster. The role dynamically generates a connector manifest from a Jinja2 template and applies it to the cluster, allowing users to configure routing and connectivity for their applications.

## Tasks

- **Set Manifest File Path:**
  - Defines the path for the generated connector manifest and constructs the target namespace.

- **Delete Existing Manifest:**
  - Removes any previously generated connector manifest file to ensure the latest template is applied.

- **Render Manifest Template:**
  - Generates the connector manifest using the provided Jinja2 template and role variables.

- **Apply Manifest:**
  - Deploys the generated connector manifest to the target namespace in the Kubernetes cluster.

- **Debug Results:**
  - Outputs the results of the connector application for troubleshooting and verification.

## Requirements

- Ansible 2.11 or newer
- `kubernetes.core` collection installed on the control node
- A Kubernetes cluster accessible via a valid `kubeconfig`
- Skupper operator deployed in the target namespace

## Role Variables

### Default Variables (from `defaults/main.yml`):
- `expose_connector_routing_key`: Routing key for the connector (default: `backend`).
- `expose_connector_metadata_name`: Metadata name for the connector (default: `backend`).
- `expose_connector_port`: Port for the connector (default: `8080`).
- `expose_connector_selector`: Selector for targeting pods (default: `app=backend`).
- `expose_connector_manifest_template`: Path to the Jinja2 template for the connector manifest (default: `connector.yml.j2`).
- `expose_connector_state`: Desired state of the resource (`present` or `absent`, default: `present`).

### Required Variables (from inventory or host_vars):
- `namespace_prefix`: Prefix for the Kubernetes namespace.
- `namespace_name`: Base name of the Kubernetes namespace.
- `kubeconfig`: Path to the kubeconfig file for connecting to the cluster.

## Template Details

The connector manifest template (`templates/connector.yml.j2`) is structured as follows:

```yaml
apiVersion: skupper.io/v2alpha1
kind: Connector
metadata:
  name: {{ expose_connector_metadata_name }}
spec:
  routingKey: {{ expose_connector_routing_key }}
  port: {{ expose_connector_port }}
  selector: {{ expose_connector_selector }}
```

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Include the expose_connector role
      ansible.builtin.include_role:
        name: rhsiqe.skupper.expose_connector
      vars:
        namespace_prefix: zago
        namespace_name: hello-world
        kubeconfig: /path/to/kubeconfig
```

### Inventory (host_vars)

```yaml
# host_vars for target host
namespace_prefix: zago
namespace_name: hello-world
kubeconfig: /path/to/kubeconfig
```

## Notes

- The namespace for the connector is derived from `namespace_prefix` and `namespace_name` (e.g., `zago-hello-world`).
- Ensure that `kubeconfig` is valid and accessible from the control node.
- This role leverages the `kubernetes.core.k8s` module for declarative resource management in Kubernetes.
- The connector manifest template can be customized as needed by modifying `templates/connector.yml.j2`.

## License

This project is licensed under the Apache License, Version 2.0. See the LICENSE file for details.