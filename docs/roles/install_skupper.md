# Role: install_skupper

This Ansible role automates the installation of Skupper using its Helm chart, ensuring a streamlined and efficient deployment process.

## Tasks

- **Clone Skupper Repository:**
  - Clones the specified Skupper repository and branch to a temporary directory.
- **Install Skupper Using Helm:**
  - Deploys Skupper in the specified Kubernetes namespace using the Helm chart.
  - There are two installation modes: `cluster` and `namespace`.
    - `cluster`: Installs Skupper in the entire Kubernetes cluster.
        - The skupper controller namespace needs to be specified in the `skupper_namespace` variable.
    - `namespace`: Installs Skupper in a specific namespace.
- **Clean Up Temporary Directory:**
  - Removes the cloned repository to maintain a clean environment.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`
- Helm version 3 or newer installed on the control node
- Git installed on the control node

## Role Variables

| Variable                               | Default Value                             | Description                                                                 |
|----------------------------------------|-------------------------------------------|-----------------------------------------------------------------------------|
| `install_skupper_skupper_repository`  | `https://github.com/skupperproject/skupper.git` | URL of the Skupper repository.                                             |
| `install_skupper_version`      | `v2`                                      | Branch of the Skupper repository to clone.                                  |
| `install_skupper_skupper_release_name`| `skupper-setup`                           | Release name for Skupper.                                                  |
| `install_skupper_install_output_path` | `/tmp/localhost`                          | Directory where the repository will be cloned temporarily.                 |
| `install_skupper_scope`               | `cluster`                                 | Scope of the Skupper installation (cluster or namespace).                  |
| `skupper_namespace`                   | `default`                                 | Kubernetes namespace for Skupper installation. If `cluster`, specify the namespace where the Skupper controller will be deployed. |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Install Skupper using Helm
      ansible.builtin.include_role:
        name: rhsiqe.skupper.install_skupper
      vars:
        install_skupper_version: "v2"
        install_skupper_install_output_path: "/tmp/skupper"
        skupper_namespace: "skupper-namespace"
```

### Inventory (host_vars)

#### `east.yml`

```yaml
kubeconfig: /path/to/east/kubeconfig
install_skupper_install_output_path: "/tmp/skupper"
skupper_namespace: "east-namespace"
```

#### `west.yml`

```yaml
kubeconfig: /path/to/west/kubeconfig
install_skupper_install_output_path: "/tmp/skupper"
skupper_namespace: "west-namespace"
```

## Notes

- The new Helm-based installation method simplifies the deployment and management of Skupper in Kubernetes clusters.
- Ensure the `kubernetes.core.helm` plugin is installed and properly configured on the control node.
- This role supports Helm version 3 and above, leveraging its capabilities for reliable Kubernetes deployments.
- The role will check the pods in the specified namespace to ensure that the Skupper controller is running successfully based on the labelSelector=app.kubernetes.io/part-of=skupper

## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.


