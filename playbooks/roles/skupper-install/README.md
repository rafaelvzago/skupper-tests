# Skupper Install Role

The `skupper-install` role automates the setup of Skupper by cloning the Skupper repository, installing Custom Resource Definitions (CRDs), and applying the Skupper controller manifest to a Kubernetes cluster. This role allows flexible configuration options, enabling users to specify the Skupper repository and branch, as well as the controller manifest to be applied.

## Role Structure

```plaintext
skupper-install
├── defaults
│   └── main.yml               # Default variables for Skupper setup
├── files                      # Additional files (currently empty)
├── handlers
│   └── main.yml               # Handlers (if needed)
├── meta
│   └── main.yml               # Role metadata
├── tasks
│   └── main.yml               # Main tasks for Skupper installation
├── templates                  # Templates (currently empty)
└── vars
    └── main.yml               # Variables specific to the role
```

## Role Variables

The following variables can be configured in the playbook or in a group/host variable file:

- `skupper_repository`: URL of the Skupper Git repository to clone (e.g., `https://github.com/skupperproject/skupper`).
- `skupper_branch`: Branch of the Skupper repository to use (e.g., `main` or `release-branch`).
- `skupper_controller_manifest`: Path to the Skupper controller manifest file, which will be applied to the Kubernetes cluster.

## Tasks Overview

### 1. Debugging Role Variables

Prints the values of key role variables for troubleshooting and verification.

### 2. Creating a Temporary Directory

Creates a temporary directory where the Skupper repository will be cloned. This directory is removed automatically after the role completes.

### 3. Cloning the Skupper Repository

Clones the specified branch of the Skupper repository into the temporary directory. This allows access to Skupper's CRDs and controller manifest.

### 4. Finding Skupper CRD Files

Searches for all CRD YAML files in the `api/types/crds` directory of the Skupper repository. These files define the Custom Resource Definitions required by Skupper.

### 5. Installing Skupper CRDs

Applies each CRD file found in the repository to the Kubernetes cluster. Only changes are logged, with detailed output suppressed for brevity.

### 6. Setting Applied Files

Tracks which CRD files were applied, storing them in the `applied_files` variable for easy reference.

### 7. Printing Applied Files

Logs each applied CRD file if any files were changed during the installation.

### 8. Installing the Skupper Controller

Applies the Skupper controller manifest specified by the `skupper_controller_manifest` variable. This sets up the Skupper controller in the cluster.

## Example Usage

To use this role in a playbook, include it as follows:

```yaml
- name: Install Skupper in the Kubernetes cluster
  hosts: all
  roles:
    - role: skupper-install
      vars:
        skupper_repository: "https://github.com/skupperproject/skupper"
        skupper_branch: "main"
        skupper_controller_manifest: "/path/to/skupper-controller.yaml"
```

## Debugging and Verification

For verification, this role provides debugging messages with key variables and details of the applied files, making it easy to confirm successful execution.

License
-------

Apache License 2.0

Author Information
------------------

This role was created by the Skupper project maintainers. For more information, visit [Skupper.io](https://skupper.io).

Rafael Zago <rzago@redhat.com>
```
