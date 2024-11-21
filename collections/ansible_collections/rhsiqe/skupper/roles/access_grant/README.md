# Role: access_grant

This Ansible role manages Skupper AccessGrant resources in a Kubernetes cluster. It allows you to define, render, and apply AccessGrant manifests using a template, with customization options for redemptions, expiration, and namespace.

## Tasks

- **Set Namespace Name:**
  - Combines the prefix and base namespace name to form the target namespace.
- **Clean Existing Manifests:**
  - Ensures old AccessGrant manifests are removed to prevent conflicts.
- **Render Manifest Template:**
  - Generates the AccessGrant manifest from a Jinja2 template.
- **Apply Manifest:**
  - Creates or updates the AccessGrant resource in the specified namespace.
- **Wait for Readiness:**
  - Polls the AccessGrant resource until it is in a `Ready` state.

## Requirements

- Ansible 2.10 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

- **Default Variables:**
  - `access_grant_name`: Name of the AccessGrant resource (default: `my-grant`).
  - `access_grant_redemptions_allowed`: Number of redemptions allowed for the AccessGrant (default: `10`).
  - `access_grant_expiration_window`: Expiration window for the AccessGrant, specified as a duration (default: `1h`).
  - `access_grant_state`: Desired state of the AccessGrant resource (default: `present`).
  - `access_grant_template`: Path to the Jinja2 template for the AccessGrant manifest (default: `access-grant.yml.j2`).

- **Inventory Variables:**
  - `kubeconfig`: Path to the kubeconfig file for connecting to the Kubernetes cluster.
  - `namespace_prefix`: Prefix for the namespace where the AccessGrant will be created.
  - `namespace_name`: Base name for the namespace.

## Template Details

The AccessGrant manifest is generated from a Jinja2 template (`access-grant.yml.j2`) with the following structure:

```yaml
apiVersion: skupper.io/v2alpha1
kind: AccessGrant
metadata:
  name: {{ access_grant_name }}
spec:
  redemptionsAllowed: {{ access_grant_redemptions_allowed }}
  expirationWindow: "{{ access_grant_expiration_window }}"
```

## Example Usage

Define variables and call the role in your playbook. Customize the namespace and AccessGrant properties as needed.

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Manage AccessGrant
      ansible.builtin.include_role:
        name: rhsiqe.skupper.access_grant
      vars:
        namespace_prefix: example
        namespace_name: skupper
        access_grant_name: my-access-grant
        access_grant_redemptions_allowed: 5
        access_grant_expiration_window: 2h
```

### Inventory (host_vars)

```yaml
# host_vars for target host
kubeconfig: /path/to/kubeconfig
namespace_prefix: example
namespace_name: skupper
```

## Notes

- The namespace used will be in the format: `<namespace_prefix>-<namespace_name>`.
- Ensure the `kubeconfig` and namespace variables are defined at the inventory level.
- The role uses the `kubernetes.core.k8s` module for managing Kubernetes resources, enabling a declarative configuration approach.

## Testing

Tests for this role are located in the `tests` directory and include:

- Inventory setup (`inventory/hosts.yml`)
- Host-specific variables (`host_vars/localhost.yml`)
- Group-specific variables (`group_vars/all.yml`)
- Test playbook (`test_playbook.yml`)

Run the test playbook to validate role functionality:

```bash
ansible-playbook -i tests/inventory/hosts.yml tests/test_playbook.yml
```

## License

This project is licensed under the Apache License 2.0. See the LICENSE file for details.