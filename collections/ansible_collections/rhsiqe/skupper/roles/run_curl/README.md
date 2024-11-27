```markdown
# Role: run_curl

This Ansible role executes a `curl` command within a Kubernetes cluster using a specified container image. The `curl` request is run inside a pod created dynamically within a defined namespace. The role ensures retries for pod creation and log retrieval to handle transient issues.

## Tasks

- **Set Namespace:**
  - Constructs the namespace name using a prefix and a base name provided via variables.
- **Run Curl Command:**
  - Creates a Kubernetes pod to execute the `curl` command targeting a specified address.
- **Retrieve Logs:**
  - Captures the logs from the pod to output the results of the `curl` command.
- **Debug Output:**
  - Displays the `curl` output for verification and debugging.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

### Defaults (from `defaults/main.yml`)

- `run_curl_namespace`: Default namespace for the pod. (Default: `default`)
- `run_curl_address`: The target URL for the `curl` command. (Default: `http://example.com`)
- `run_curl_image`: The container image used to execute the `curl` command. (Default: `quay.io/rzago/curl-telnet`)
- `run_curl_retries`: Number of retry attempts for pod creation. (Default: `10`)
- `run_curl_delay`: Delay in seconds between retries for pod creation. (Default: `10`)

### Required Variables

These must be defined in the playbook or inventory:

- `namespace_prefix`: Prefix for constructing the namespace name.
- `namespace_name`: Base name for constructing the namespace.

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Run curl command in Kubernetes
      ansible.builtin.include_role:
        name: rhsiqe.skupper.run_curl
      vars:
        namespace_prefix: "test"
        namespace_name: "east"
        run_curl_address: "http://my-service.namespace.svc.cluster.local"
```

### Inventory (host_vars)

#### `host_vars/east.yml`

```yaml
kubeconfig: /path/to/east/kubeconfig
namespace_name: east
```

#### `host_vars/west.yml`

```yaml
kubeconfig: /path/to/west/kubeconfig
namespace_name: west
```

## Notes

- The final namespace is constructed as `<namespace_prefix>-<namespace_name>` (e.g., `test-east`).
- The `run_curl_address` should be updated to target the desired service or endpoint in the cluster.
- The pod created is ephemeral, and its logs are used to capture the `curl` command output.
- This role uses the `kubernetes.core.k8s` and `kubernetes.core.k8s_log` modules, ensuring a declarative and robust approach for Kubernetes resource management.

## License

Apache License 2.0
```