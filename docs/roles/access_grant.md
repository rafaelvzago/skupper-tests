# Role: access_grant

This Ansible role automates the creation and management of `AccessGrant` and `AccessToken` resources in a Kubernetes cluster using the Skupper API. It ensures the generation of manifests from templates, applies them to the cluster, and waits for the resources to reach a ready state. 

## Tasks

- **Generate AccessGrant and AccessToken Manifests:**
  - Renders manifests from Jinja2 templates for `AccessGrant` and `AccessToken` resources.
- **Apply Manifests to Kubernetes Cluster:**
  - Uses `kubernetes.core.k8s` to apply the generated manifests.
- **Monitor Resource State:**
  - Waits for `AccessGrant` to be ready and verifies the state of pods in the namespace.
- **Extract Resource Details:**
  - Captures the details of the created `AccessGrant` and outputs relevant data for further use.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`
- Skupper installed and configured in the target namespaces

## Role Variables

| Variable                             | Default Value                 | Description                                                                 |
|--------------------------------------|-------------------------------|-----------------------------------------------------------------------------|
| `access_grant_name`                  | `my-grant`                    | Name of the `AccessGrant` resource.                                         |
| `access_grant_redemptions_allowed`   | `10`                          | Number of redemptions allowed for the `AccessGrant`.                        |
| `access_grant_expiration_window`     | `1h`                          | Expiration window for the `AccessGrant`.                                    |
| `access_grant_state`                 | `present`                     | Desired state of the `AccessGrant` resource (`present` or `absent`).        |
| `access_grant_template`              | `access-grant.yml.j2`         | Path to the Jinja2 template for `AccessGrant`.                              |
| `access_grant_token_template`        | `access_token.yml.j2`         | Path to the Jinja2 template for `AccessToken`.                              |
| `access_grant_output_path`           | `/tmp/localhost`              | Directory where the generated manifest files will be stored.               |
| `namespace_prefix`                   |                               | Prefix for the Kubernetes namespace.                                        |
| `namespace_name`                     |                               | Name of the Kubernetes namespace.                                           |
| `kubeconfig`                         |                               | Path to the kubeconfig file for cluster access.                             |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Include the access_grant role
      ansible.builtin.include_role:
        name: rhsiqe.skupper.access_grant
      vars:
        namespace_prefix: "skupper"
        namespace_name: "east"
        access_grant_name: "my-access-grant"
        access_grant_redemptions_allowed: 5
        access_grant_expiration_window: "2h"
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

- The `namespace` is derived as `<namespace_prefix>-<namespace_name>`.
- Generated manifests are stored in the `access_grant_output_path` directory, named according to the inventory host.
- The `AccessGrant` details (e.g., `ca`, `code`, and `url`) are captured and available for further use.
- Ensure that the `kubernetes.core` collection is installed to use the `kubernetes.core.k8s` module.

## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.