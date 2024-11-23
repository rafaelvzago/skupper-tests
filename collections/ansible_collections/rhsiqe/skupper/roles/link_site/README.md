# Role: link_site

This Ansible role applies an AccessToken in a specified Kubernetes namespace, enabling secure communication between Skupper sites. It dynamically generates the namespace name using a prefix and base name, then applies the AccessToken from a given manifest path.

## Tasks

- **Set Namespace Name:**
  - Constructs the namespace name and related variables using a provided prefix and base name.
- **Apply AccessToken:**
  - Applies the AccessToken manifest to the target namespace using the `kubernetes.core.k8s` module.
- **Debug Results:**
  - Outputs the result of the AccessToken application for verification.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

The following variables can be configured:

### Defaults (from `defaults/main.yml`)

- `link_site_access_token_name`: Name of the AccessToken. Default is `"access-token"`.
- `link_site_target_namespace`: Target namespace for the AccessToken. Default is `"default"`.
- `link_site_access_token_path`: Path to the AccessToken manifest file. Default is empty (`""`).

### Additional Variables

- `namespace_prefix`: Prefix for the namespace (set in the playbook or inventory).
- `namespace_name`: Base name for the namespace (set in the inventory).
- `kubeconfig`: Path to the kubeconfig file for accessing the Kubernetes cluster.

## Example Usage

Define the required variables in your playbook and inventory to configure the role:

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Link a site using AccessToken
      ansible.builtin.include_role:
        name: rhsiqe.skupper.link_site
      vars:
        namespace_prefix: "skupper"
        link_site_access_token_path: "/path/to/access-token.yml"
```

### Inventory (host_vars)

```yaml
# host_vars for target host
kubeconfig: /path/to/kubeconfig
namespace_name: site-east
```

## Notes

- The namespace is generated in the format `<namespace_prefix>-<namespace_name>`. For example, with `namespace_prefix: skupper` and `namespace_name: site-east`, the resulting namespace will be `skupper-site-east`.
- Ensure that the AccessToken manifest exists at the path specified in `link_site_access_token_path`.
- The `kubernetes.core.k8s` module is used for declarative application of Kubernetes resources, ensuring robust and consistent operations.
- This role requires the `kubeconfig` variable to be correctly set in the inventory for each target host to access the Kubernetes cluster.

## Testing

The role includes a test playbook located in `tests/test_playbook.yml`, along with sample inventory and variable files for testing. Adjust the test configurations as needed to match your environment. 

## License

This role is licensed under the Apache License 2.0.