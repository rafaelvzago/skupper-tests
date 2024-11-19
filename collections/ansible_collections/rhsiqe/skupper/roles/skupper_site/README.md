# Role: skupper_site

This Ansible role configures a Skupper site in a Kubernetes cluster. It generates a Skupper site manifest using a Jinja2 template, applies it to the specified namespace, and ensures all necessary pods are running. The role is customizable via various variables and integrates with Kubernetes using the `kubernetes.core` collection.

## Tasks

- **Generate Manifest:**
  - Creates a Skupper site manifest file using a Jinja2 template.
- **Apply Manifest:**
  - Applies the generated manifest to the specified namespace in the Kubernetes cluster.
- **Ensure Readiness:**
  - Waits until all pods in the Skupper namespace are in the `Running` state.

## Requirements

- Ansible 2.9 or newer
- `kubernetes.core` collection installed
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

- **Defaults (in `defaults/main.yml`):**
  - `skupper_site_file`: Path to the Skupper site manifest file (default: `files/skupper-site.yml`).
  - `skupper_site_namespace`: Namespace for deploying the Skupper site (default: `default`).
  - `skupper_site_state`: Desired state of the Skupper site (e.g., `present` or `absent`, default: `present`).
  - `skupper_site_manifest_template`: Jinja2 template for generating the Skupper site manifest (default: `skupper-site.yml.j2`).
  - `skupper_site_include_spec`: Boolean to include the `spec` section in the manifest (default: `true`).
  - `skupper_site_link_access`: Default `linkAccess` value in the `spec` section (default: `default`).

- **Required Inventory Variables:**
  - `namespace_prefix`: Prefix for the namespace (e.g., `team` or `project`).
  - `namespace_name`: Base name of the namespace (e.g., `app1`, `app2`).
  - `kubeconfig`: Path to the `kubeconfig` file for cluster access.

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Deploy a Skupper site
      ansible.builtin.include_role:
        name: rhsiqe.skupper.skupper_site
      vars:
        namespace_prefix: demo
        namespace_name: skupper-app
        skupper_site_state: present
```

### Inventory

#### `host_vars/localhost.yml`

```yaml
kubeconfig: /path/to/kubeconfig
namespace_prefix: demo
namespace_name: skupper-app
```

## Notes

- The namespace for Skupper will be constructed as `<namespace_prefix>-<namespace_name>` (e.g., `demo-skupper-app`).
- Ensure that the `kubeconfig` file and permissions allow access to the specified namespace.
- The role will wait up to 5 minutes (30 retries with 10 seconds delay) for pods to reach the `Running` state.

## Template Details

The Skupper site manifest template is located at `templates/skupper-site.yml.j2`. It generates a `Site` resource using the specified variables. For example:

```yaml
apiVersion: skupper.io/v2alpha1
kind: Site
metadata:
  name: skupper-app
  namespace: demo-skupper-app
spec:
  linkAccess: default
```

## License

Apache License 2.0