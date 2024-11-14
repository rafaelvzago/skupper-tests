# Role: deploy_workload

This Ansible role deploys a workload as a Kubernetes deployment in a specified namespace. The namespace is constructed using a prefix and name provided as variables, and the role includes a wait task to ensure the deployment is fully ready before completion.

## Tasks

- **Set Namespace**: Constructs the namespace by combining `namespace_prefix` and `namespace_name`.
- **Deploy Workload**: Creates a Kubernetes deployment in the specified namespace with the provided workload image, replicas, and other configurations.
- **Wait for Deployment**: Monitors the status of the deployment's pods, waiting until the specified number of replicas are running.
- **Display Pods**: Outputs the names of the running pods for the deployed workload.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Access to a Kubernetes cluster via `kubeconfig`

## Role Variables

- **Role Variables**:
  - `deploy_workload_deployment_name`: Specifies the name of the deployment.
  - `deploy_workload_workload_image`: Specifies the container image for the deployment.
  - `deploy_workload_replicas`: Number of replicas to deploy. Default is 1.
- **Inventory Variables**:
  - `namespace_prefix`: Prefix used to create the namespace.
  - `namespace_name`: Base name for the namespace (e.g., `hello-world`), used to form the complete namespace.
  - `kubeconfig`: Path to the `kubeconfig` file for accessing the Kubernetes cluster.

## Example Usage

Define the deployment parameters and include the role in your playbook. Specify the namespace prefix and name in your inventory or playbook.

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Deploy workload
      include_role:
        name: deploy_workload
      vars:
        deploy_workload_deployment_name: myapp
        deploy_workload_workload_image: "nginx:latest"
        deploy_workload_replicas: 2
```

### Inventory (host_vars or group_vars)

```yaml
# host_vars for target host
namespace_prefix: "test"
namespace_name: "hello-world"
kubeconfig: "/path/to/kubeconfig"
```

### Example Output

The namespace created will follow the format `<namespace_prefix>-<namespace_name>`, and the deployment pods will be listed once they are running.

## Notes

- Ensure `namespace_prefix`, `namespace_name`, and `kubeconfig` are defined in the inventory for each target host.
- The `wait` task checks the readiness of the deployment pods, retrying until all replicas are running or a timeout is reached (30 retries, 10-second delay).
- This role uses the `kubernetes.core.k8s` module to manage Kubernetes resources directly, providing a robust alternative to shell-based `kubectl` commands.
