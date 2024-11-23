# Skupper Tests Ansible Project

## Overview

This project provides a modular and scalable framework to test and manage Skupper environments using Ansible roles and scenarios. Each role is designed with a specific purpose and includes dedicated tests to ensure functionality, reliability, and consistency. The project adheres to Ansible best practices, making it easy to maintain and extend.

---

## Key Roles

### **1. `deploy_workload`**
- **Purpose**: Deploy backend and frontend workloads in specified namespaces.
- **Tests**: Verifies successful deployment and readiness of workloads in Kubernetes.

### **2. `env_shakeout`**
- **Purpose**: Validates and prepares the Kubernetes environment for Skupper operations.
- **Tests**: Confirms connectivity and ensures all dependencies are available.

### **3. `generate_namespaces`**
- **Purpose**: Creates namespaces with specific naming conventions to segment workloads and services.
- **Tests**: Validates namespace creation and checks naming compliance.

### **4. `install_skupper`**
- **Purpose**: Installs Skupper by applying CRDs and deploying its controller.
- **Tests**: Verifies the successful application of CRDs and controller readiness.

### **5. `skupper_site`**
- **Purpose**: Configures Skupper sites, including settings like `linkAccess`.
- **Tests**: Ensures manifests are applied correctly and pods are ready.

### **6. `expose_connector`**
- **Purpose**: Creates and deploys connectors for application routing in Skupper.
- **Tests**: Validates connector configuration and functionality.

### **7. `teardown_namespaces`**
- **Purpose**: Cleans up namespaces and removes Skupper-related resources.
- **Tests**: Confirms successful cleanup and deletion of resources.

### **8. `access_grant`**
- **Purpose**: Manages access credentials for Skupper endpoints.
- **Tests**: Validates access token generation and configuration.

### **9. `consume_service`**
- **Purpose**: Configures listeners for consuming services via Skupper.
- **Tests**: Ensures listener setup and service consumption.

### **10. `link_site`**
- **Purpose**: Establishes site links between Skupper instances.
- **Tests**: Confirms link creation and connectivity.

### **11. `install_skupper_controller`**
- **Purpose**: Installs and configures the Skupper controller for advanced settings.
- **Tests**: Verifies controller setup and operational readiness.

---

## Folder Structure

```plaintext
skupper-tests/
├── ansible.cfg                 # Ansible configuration file
├── devfile.yaml                # Devfile for project setup
├── Makefile                    # Automates tasks like dependency installation
├── .ansible-lint               # Configuration for linting
├── .gitignore                  # Git ignore rules
├── LICENSE                     # License file
├── README.md                   # Documentation for the project
├── requirements.txt            # Python dependencies
├── requirements.yml            # Ansible collection dependencies
├── run_all_tests.sh            # Script to execute all tests
├── scenarios/                  # Example scenarios like hello-world
│   └── hello-world/
│       ├── hello-world.yml     # Playbook for hello-world scenario
│       └── inventory/          # Inventory for hello-world scenario
│           ├── hosts.yml
│           ├── group_vars/
│           └── host_vars/
├── test_results/               # Logs for test runs
└── collections/
    ├── ansible_collections/
    │   └── rhsiqe/
    │       └── skupper/
    │           ├── galaxy.yml       # Metadata for the collection
    │           ├── README.md        # Documentation for the collection
    │           └── roles/
    │               ├── access_grant/
    │               ├── consume_service/
    │               ├── deploy_workload/
    │               ├── env_shakeout/
    │               ├── expose_connector/
    │               ├── generate_namespaces/
    │               ├── install_skupper/
    │               ├── install_skupper_controller/
    │               ├── link_site/
    │               ├── skupper_site/
    │               └── teardown_namespaces/
    └── requirements.yml
```

---

## Usage Instructions

### **1. Installing rules**

1. Install dependencies:
   ```bash
   make build
   ```
2. Run the test script:
   ```bash
   make tests
   ```
3. View test results in `test_results/` and review logs for each role.

---

### **3. Running Example Scenarios**

Navigate to a scenario directory and execute the playbook. For example, to run the `hello-world` scenario:

```bash
ansible-playbook -i scenarios/hello-world/inventory/hosts.yml scenarios/hello-world/hello-world.yml
```

---

## Compatibility

- **Tested with**: `ansible-lint >= 24.2.0`
- **Compatible with**: `ansible-core`

---

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.