# Role: install_skupper

This Ansible role automates the installation of Skupper by cloning its repository, applying Custom Resource Definitions (CRDs), and cleaning up temporary files.

## Tasks

- **Clone Skupper Repository:**
  - Clones the specified Skupper repository and branch to a temporary directory.
- **Find CRD Files:**
  - Locates the CRD YAML files in the repository.
- **Apply CRDs to Kubernetes:**
  - Installs the Skupper CRDs in the specified Kubernetes cluster using `kubernetes.core.k8s`.
- **Clean Up Temporary Directory:**
  - Removes the cloned repository to maintain a clean environment.

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`
- Git installed on the control node

## Role Variables

| Variable                               | Default Value                             | Description                                                                 |
|----------------------------------------|-------------------------------------------|-----------------------------------------------------------------------------|
| `install_skupper_skupper_repository`  | `https://github.com/skupperproject/skupper.git` | URL of the Skupper repository.                                             |
| `install_skupper_skupper_branch`      | `v2`                                      | Branch of the Skupper repository to clone.                                 |
| `install_skupper_skupper_release_name`| `skupper-setup`                           | Release name for Skupper. (Currently unused.)                              |
| `install_skupper_install_output_path` | `/tmp/localhost`                          | Directory where the repository will be cloned temporarily.                 |
| `kubeconfig`                          |                                           | Path to the kubeconfig file for cluster access. **Mandatory.**             |

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Install Skupper in the target cluster
      ansible.builtin.include_role:
        name: rhsiqe.skupper.install_skupper
      vars:
        install_skupper_skupper_branch: "v2"
        install_skupper_install_output_path: "/tmp/skupper"
```

### Inventory (host_vars)

#### `east.yml`

```yaml
kubeconfig: /path/to/east/kubeconfig
install_skupper_install_output_path: "/tmp/skupper"
```

#### `west.yml`

```yaml
kubeconfig: /path/to/west/kubeconfig
install_skupper_install_output_path: "/tmp/skupper"
```

## Notes

- The CRDs are applied in the specified Kubernetes cluster, ensuring Skupper components can be deployed.
- The role cleans up the temporary directory after applying the CRDs.
- Ensure Git is installed on the control node for cloning the repository.

## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.