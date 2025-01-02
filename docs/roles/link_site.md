# Role: link_site

The `link_site` Ansible role establishes a connection between Skupper sites by applying an `AccessToken` to the target Kubernetes namespace. This enables inter-site communication in a Skupper topology.

## Tasks

- **Set Namespace and Token Path:**
  - Determines the namespace and sets the path to the `AccessToken` manifest file.
- **Apply AccessToken:**
  - Uses the `kubernetes.core.k8s` module to apply the `AccessToken` in the target namespace.
- **Debug Application Result:**
  - Outputs the results of the applied `AccessToken` for verification.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`
- A valid `AccessToken` manifest available at the specified path

## Role Variables

| Variable                   | Default Value          | Description                                                                 |
|----------------------------|------------------------|-----------------------------------------------------------------------------|
| `link_site_access_token_name` | `access-token`        | Name of the `AccessToken` resource.                                         |
| `link_site_target_namespace`  | `default`             | Target namespace where the `AccessToken` will be applied.                  |
| `link_site_access_token_path` |                      | Path to the `AccessToken` manifest. **Must be defined in playbook/inventory.** |
| `namespace_prefix`          |                        | Prefix for the namespace.                                                  |
| `namespace_name`            |                        | Name of the namespace.                                                     |
| `kubeconfig`                |                        | Path to the kubeconfig file for accessing the Kubernetes cluster. **Mandatory.** |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Link Skupper sites
      ansible.builtin.include_role:
        name: rhsiqe.skupper.link_site
      vars:
        namespace_prefix: "skupper"
        namespace_name: "east"
        link_site_access_token_path: "/path/to/east-access-token.yml"
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
- Ensure the `link_site_access_token_path` variable is defined and points to a valid `AccessToken` manifest.
- The role uses the `kubernetes.core.k8s` module, which requires the `kubernetes.core` collection to be installed.

## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.