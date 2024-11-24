# Role: skupper_site

The `skupper_site` Ansible role automates the creation and management of Skupper `Site` resources in a Kubernetes cluster. It generates and applies manifests, ensures resources are correctly deployed, and verifies the readiness of Skupper router pods.

## Tasks

- **Set Manifest File Path:**
  - Determines the output path for the Skupper site manifest.
- **Render Manifest from Template:**
  - Creates the Skupper `Site` resource manifest using a Jinja2 template.
- **Apply Manifest to Kubernetes:**
  - Uses the `kubernetes.core.k8s` module to create or update the Skupper `Site` resource.
- **Verify Resource Readiness:**
  - Checks that all Skupper router pods in the namespace are in a `Running` state.
- **Debug Results and Pod List:**
  - Outputs the results of applied resources and lists running pods for confirmation.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

| Variable                         | Default Value                 | Description                                                                 |
|----------------------------------|-------------------------------|-----------------------------------------------------------------------------|
| `skupper_site_file`              | `files/skupper-site.yml`      | Path to the Skupper site manifest file.                                     |
| `skupper_site_namespace`         | `default`                     | Namespace for the Skupper `Site` resource.                                  |
| `skupper_site_state`             | `present`                     | Desired state of the `Site` resource (`present` or `absent`).               |
| `skupper_site_manifest_template` | `skupper-site.yml.j2`         | Template for generating the Skupper site manifest.                         |
| `skupper_site_include_spec`      | `true`                        | Whether to include the `spec` section in the manifest.                      |
| `skupper_site_link_access`       | `default`                     | Default value for `linkAccess` in the site specification.                   |
| `skupper_site_output_path`       | `/tmp/localhost`              | Directory where the generated manifest will be stored.                      |
| `namespace_prefix`               |                               | Prefix for the Kubernetes namespace.                                        |
| `namespace_name`                 |                               | Name of the Kubernetes namespace.                                           |
| `kubeconfig`                     |                               | Path to the kubeconfig file for accessing the Kubernetes cluster. **Mandatory.** |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Configure a Skupper site
      ansible.builtin.include_role:
        name: rhsiqe.skupper.skupper_site
      vars:
        namespace_prefix: "skupper"
        namespace_name: "east"
        skupper_site_link_access: "public"
        skupper_site_output_path: "/tmp/skupper"
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
- The manifest file is stored in `skupper_site_output_path`, named according to the inventory host.
- Ensure the `kubernetes.core.k8s` module is installed to use this role.
- All pods in the namespace are checked to ensure they are in a `Running` state before completion.

## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.