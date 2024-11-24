# Role: teardown_test

The `teardown_test` Ansible role removes test environments created during Skupper testing. It deletes the specified namespace, waits for its successful removal, and cleans up temporary directories.

## Tasks

- **Delete Test Namespace:**
  - Deletes the specified Kubernetes namespace using the `kubernetes.core.k8s` module.
- **Wait for Namespace Deletion:**
  - Ensures the namespace is completely removed by checking its absence.
- **Delete Temporary Directories:**
  - Removes any temporary directories specified for the test environment.
- **Display Cleanup Summary:**
  - Outputs a summary of the deleted resources for verification.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

| Variable                     | Default Value | Description                                                       |
|------------------------------|---------------|-------------------------------------------------------------------|
| `namespace_prefix`           |               | Prefix for the namespace to be deleted.                          |
| `namespace_name`             |               | Name of the namespace to be deleted.                             |
| `kubeconfig`                 |               | Path to the kubeconfig file for accessing the Kubernetes cluster. |
| `teardown_test_temp_dir_path`|               | Path to the temporary directory to be deleted.                   |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Teardown test environment
      ansible.builtin.include_role:
        name: rhsiqe.skupper.teardown_test
      vars:
        namespace_prefix: "skupper"
        namespace_name: "test"
        teardown_test_temp_dir_path: "/tmp/skupper-test"
```

### Inventory (host_vars)

#### `localhost.yml`

```yaml
kubeconfig: /path/to/kubeconfig
namespace_prefix: "skupper"
namespace_name: "test"
teardown_test_temp_dir_path: "/tmp/skupper-test"
```

## Notes

- The namespace is derived as `<namespace_prefix>-<namespace_name>`.
- The role ensures all resources are cleaned up, including temporary directories used during tests.
- Ensure the `kubernetes.core.k8s` module is installed to use this role.
- Namespace deletion may take some time; the role retries the check for up to 20 attempts with a 2-second delay between each.

## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.