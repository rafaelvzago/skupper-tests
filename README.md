# Skupper Tests - Ansible Project

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)  
[![Latest Release](https://img.shields.io/github/v/tag/rafaelvzago/skupper-tests)](https://github.com/rafaelvzago/skupper-tests/tags)

## Overview

This project provides a modular and scalable framework to test and manage Skupper environments using Ansible roles and scenarios. Each role targets a specific functionality in a Skupper-based architecture, offering flexibility, reliability, and adherence to Ansible best practices. The project includes detailed tests for every role to ensure a robust and maintainable solution.

---

## Key Roles

### **1. `deploy_workload`**
- **Purpose**: Deploy backend and frontend workloads in specified namespaces.
- **Tests**: Verifies successful deployment and readiness of workloads in Kubernetes.

### **2. `env_shakeout`**
- **Purpose**: Validates and prepares the Kubernetes environment for Skupper operations.
- **Tests**: Confirms cluster connectivity and ensures dependencies are available.

### **3. `generate_namespaces`**
- **Purpose**: Creates namespaces with specific naming conventions to segment workloads and services.
- **Tests**: Validates namespace creation and ensures naming compliance.

### **4. `install_skupper`**
- **Purpose**: Installs Skupper by applying CRDs and deploying its controller.
- **Tests**: Verifies the successful application of CRDs and controller readiness.

### **5. `skupper_site`**
- **Purpose**: Configures Skupper sites, including advanced settings like `linkAccess`.
- **Tests**: Ensures manifests are applied correctly and that all pods are ready.

### **6. `create_connector`**
- **Purpose**: Creates and deploys connectors for application routing in Skupper.
- **Tests**: Validates connector configuration and functionality.

### **7. `expose_service`**
- **Purpose**: Exposes services in Kubernetes namespaces for external access.
- **Tests**: Confirms service exposure and connectivity.

### **8. `access_grant`**
- **Purpose**: Manages access credentials for Skupper endpoints.
- **Tests**: Validates access token generation and usage.

### **9. `create_listener`**
- **Purpose**: Configures listeners for consuming services via Skupper.
- **Tests**: Ensures listener setup and service consumption.

### **10. `link_site`**
- **Purpose**: Establishes site links between Skupper instances.
- **Tests**: Confirms successful link creation and connectivity.

### **11. `install_skupper_controller`**
- **Purpose**: Installs and configures the Skupper controller for advanced cluster settings.
- **Tests**: Verifies controller setup and operational readiness.

### **12. `teardown_test`**
- **Purpose**: Cleans up namespaces and removes Skupper-related resources after testing.
- **Tests**: Ensures proper cleanup and verifies resource deletion.

### **13. `run_curl`**
- **Purpose**: Runs a test to validate Skupper connectivity.
- **Tests**: Validates Skupper connectivity and service availability.

---

## Folder Structure

```plaintext
skupper-tests/
├── ansible.cfg                  # Ansible configuration file
├── Makefile                     # Automates tasks like dependency installation
├── .ansible-lint                # Configuration for linting
├── .gitignore                   # Git ignore rules
├── LICENSE                      # License file
├── README.md                    # Documentation for the project
├── requirements.txt             # Python dependencies
├── run_all_tests.sh             # Script to execute all tests
├── scenarios/                   # Example scenarios like hello-world
│   └── hello-world/ 
│       ├── hello-world.yml      # Playbook for hello-world scenario
│       └── inventory/           # Inventory for hello-world scenario
│           ├── hosts.yml
│           ├── group_vars/      # Group variables for hello-world scenario
│           └── host_vars/
├── test_results/                # Logs for test runs
└── collections/
    ├── ansible_collections/
    │   └── rhsiqe/
    │       └── skupper/
    │           ├── galaxy.yml   # Metadata for the collection
    │           ├── README.md    # Documentation for the collection
    │           └── roles/
    │               ├── access_grant/
    │               ├── create_listener/
    │               ├── deploy_workload/
    │               ├── env_shakeout/
    │               ├── create_connector/
    │               ├── expose_service/
    │               ├── generate_namespaces/
    │               ├── install_skupper/
    │               ├── install_skupper_controller/
    │               ├── link_site/
    │               ├── run_curl_test/
    │               ├── skupper_site/
    │               └── teardown_test/
    └── requirements.yml       # Collection dependencies
```

---

## Test Instructions

### Running Role-Specific Tests

Each role has its own test playbook, allowing independent testing. For example, to test the `access_grant` role:

```bash
ansible-playbook collections/ansible_collections/rhsiqe/skupper/roles/access_grant/tests/test_playbook.yml \
  -i collections/ansible_collections/rhsiqe/skupper/roles/access_grant/tests/inventory/hosts.yml
```

The role tests will automatically invoke any dependent roles required to create the appropriate test scenario.

---

### Running All Tests

Use the `make tests` command to run all tests in a logical order. This ensures the dependencies between roles are respected, and the environment is set up and torn down cleanly. The test script automatically logs results for review.

#### Example:
```bash
make tests
```

The `run_all_tests.sh` script executes the roles in the following order:
1. `env_shakeout`
2. `generate_namespaces`
3. `deploy_workload`
4. `install_skupper`
5. `install_skupper_controller`
6. `skupper_site`
7. `create_connector`
8. `create_listener`
9. `access_grant`
10. `link_site`
11. `expose_service`
12. `run_curl_test`

Test logs are stored in the `test_results/` directory with timestamps.

---

## Usage Instructions

### Installing Dependencies

1. Install Python and Ansible dependencies:
   ```bash
   make build
   ```
2. Run the test suite:
   ```bash
   make tests
   ```
3. Review test results in the `test_results/` directory.

### Running Example Scenarios

Navigate to a scenario directory and execute the playbook. For example, to run the `hello-world` scenario:

```bash
ansible-playbook -i scenarios/hello-world/inventory/hosts.yml scenarios/hello-world/hello-world.yml
```

---

## Scenario test hello-world

This scenario deploys a simple frontend and backend application in separate namespaces. The frontend consumes the backend service via Skupper. And it uses all the roles in the collection. Use as guide to create your own scenarios.

### Running the hello-world scenario

1. After build the roles and collections, run the hello-world scenario:
   ```bash
   ansible-playbook scenarios/hello-world/hello-world.yml -i scenarios/hello-world/inventory/hosts.yml
   ```

2. Running skipping skupper installation:
   ```bash
   ansible-playbook scenarios/hello-world/hello-world.yml -i scenarios/hello-world/inventory/hosts.yml -e skip_skupper_install=true 
   ```
3. Running skipping teardown:
   ```bash
   ansible-playbook scenarios/hello-world/hello-world.yml -i scenarios/hello-world/inventory/hosts.yml -e skip_teardown=true
   ```

### Debuging when needed (ensure that the teardown was skipped):
   
* The playbook creates a temporary folder under /tmp with the inventory name on it:

```bash
TASK [Set a unique temporary directory path per host] *********************************************************************************************************************************************************************************************
task path: /home/rzago/Code/skupper-tests/scenarios/hello-world/hello-world.yml:4
ok: [west] => {"ansible_facts": {"temp_dir_path": "/tmp/ansible.west"}, "changed": false}
ok: [east] => {"ansible_facts": {"temp_dir_path": "/tmp/ansible.east"}, "changed": false}
```

Inside this folder you will find the logs and the inventory file used to run the playbook:

```bash
❯ ls -l /tmp/ansible.east
total 8
-rw-r--r--. 1 rzago rzago 143 Nov 24 16:41 connector-east.yml        # Connector file
-rw-r--r--. 1 rzago rzago 113 Nov 24 16:41 skupper-site-east.yml     # Skupper site file
❯ ls -l /tmp/ansible.west/
total 16
-rw-r--r--. 1 rzago rzago  132 Nov 24 16:41 access-grant-west.yml    # Access grant
-rw-r--r--. 1 rzago rzago 1454 Nov 24 16:42 access-token-west.yml    # Access token file
-rw-r--r--. 1 rzago rzago  134 Nov 24 16:41 consume-service-west.yml # Consume service file
-rw-r--r--. 1 rzago rzago  141 Nov 24 16:41 skupper-site-west.yml    # Skupper site file
```


## Compatibility

- **Tested with**: `ansible-lint >= 24.2.0`
- **Compatible with**: `ansible-core`

---

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.