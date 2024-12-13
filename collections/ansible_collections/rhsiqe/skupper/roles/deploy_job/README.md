# Role: deploy_job

This Ansible role automates the deployment of a job in a Kubernetes cluster. It creates a Job resource in the specified namespace, waits for the job to be ready, and displays the running pods for verification.

## Tasks

- **Set Namespace:**
  - Derives the namespace based on the prefix and name variables.
- **Deploy Job:**
  - Creates a Job resource with the container image and job command.
- **Wait for Job Readiness:**
  - Ensures the workload is running by verifying pod statuses.
- **Display Pod Information:**
  - Outputs the names of the running pods for the deployed workload.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

| Variable                        | Default Value         | Description                                                                           |
|---------------------------------|-----------------------|---------------------------------------------------------------------------------------|
| `deploy_job_namespace_name`     | `default`             | Namespace where the job will be deployed.                                             |
| `deploy_job_job_command`        | `""` - Commented out  | Command to run in the container initialization. If not in use, keep it commented out  |
| `deploy_job_job_name`           | `jobname`             | Job name.                                                                             |  
| `deploy_job_job_image`          |                       | Container image to use for the deployment. **Must be defined in playbook/inventory.** |
| `deploy_job_restart_policy`     | `OnFailure`           | Job Restart Policy                                                                    |
| `deploy_job_dns_policy`         | `ClusterFirst`        | Job DNS Policy                                                                        |
| `deploy_job_output_path`        | `/tmp/localhost`      | Path to store any outputs (currently unused, reserved for future use).                |
| `namespace_prefix`              |                       | Prefix for the namespace (defined in inventory or playbook).                          |
| `namespace_name`                |                       | Name of the namespace (defined in inventory or playbook).                             |
| `kubeconfig`                    |                       | Path to the kubeconfig file for cluster access.                                       |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Deploy a job in the specified namespace
      ansible.builtin.include_role:
        name: rhsiqe.skupper.deploy_job
      vars:
        namespace_prefix: "skupper"
        namespace_name: "east"
        deploy_job_job_name: "my-job"
        deploy_job_job_image: "nginx:latest"
        deploy_job_restart_policy: OnFailure
        deploy_job_dns_policy: ClusterFirst
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
- Ensure `deploy_job_job_image` is defined in the playbook or inventory as it is mandatory for the deployment.
- Pods will be verified to ensure they are in the `Running` state.
- The `kubernetes.core.k8s` module is used for all Kubernetes operations, requiring the `kubernetes.core` collection to be installed.
- If the job does not requires any command to be executed in the initalization, you can keep the variable deploy_job_job_command
  commented out. Or you can set it, like this : 
  deploy_job_job_command:
   - iperf3
   - "-s"


## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.
