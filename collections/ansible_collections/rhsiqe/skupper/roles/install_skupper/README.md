# Role: install_skupper

This Ansible role automates the installation of Skupper in a Kubernetes cluster. It clones the Skupper repository, applies the required Custom Resource Definitions (CRDs), and deploys the Skupper Controller using a pre-defined manifest.

## Tasks

- **Setup Temporary Workspace:**
  - Creates a temporary directory to clone the Skupper repository.
  - Cleans up the directory after installation.
- **Clone Repository:**
  - Clones the Skupper repository from the specified branch.
- **Install CRDs:**
  - Identifies and applies all CRD YAML files from the cloned repository.
- **Deploy Skupper Controller:**
  - Installs the Skupper Controller using a manifest URL.
- **Clean Up:**
  - Removes the temporary workspace used during the installation.

## Requirements

- Ansible 2.9 or newer
- `kubernetes.core` collection installed
- Kubernetes cluster accessible via `kubeconfig`

## Role Variables

- **Defaults (in `defaults/main.yml`):**
  - `install_skupper_skupper_repository`: Repository URL for the Skupper project (default: `https://github.com/skupperproject/skupper.git`).
  - `install_skupper_skupper_branch`: Branch of the repository to clone (default: `v2`).
  - `install_skupper_skupper_controller_manifest`: URL to the Skupper Controller deployment manifest (default: `https://raw.githubusercontent.com/skupperproject/skupper/v2/cmd/controller/deploy_cluster_scope.yaml`).
  - `install_skupper_skupper_release_name`: Release name for the Skupper installation (default: `skupper-setup`).
  - `install_skupper_helm_install_scope`: Scope of the Helm installation (default: `cluster`).

- **Required Inventory Variables:**
  - `kubeconfig`: Path to the `kubeconfig` file for accessing the cluster.

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Install Skupper in the cluster
      ansible.builtin.include_role:
        name: rhsiqe.skupper.install_skupper
      vars:
        install_skupper_skupper_branch: v2
```

### Inventory

#### `host_vars/localhost.yml`

```yaml
kubeconfig: /path/to/kubeconfig
```

## Notes

- The role uses the `kubernetes.core.k8s` module to manage Kubernetes resources declaratively.
- CRDs are located in the `api/types/crds/` directory of the Skupper repository and are applied automatically.
- The role cleans up all temporary directories created during the process, ensuring no residual files are left on the control node.
- Ensure the `kubeconfig` file and permissions allow cluster-wide operations if `install_skupper_helm_install_scope` is set to `cluster`.

## License

Apache License 2.0