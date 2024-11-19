# Skupper Tests Ansible Project

## Overview

This project is designed to test and manage Skupper environments using modular Ansible roles and scenarios. Each role has dedicated tests to ensure reliable and consistent functionality. Adhering to Ansible best practices, the project structure is scalable, reusable, and easy to maintain.

---

## Key Roles

### **1. `deploy_workload`**
- **Purpose**: Deploys backend and frontend workloads in specified namespaces.
- **Tests**: Verifies successful deployment and readiness of workloads in Kubernetes.

### **2. `env_shakeout`**
- **Purpose**: Prepares the environment and ensures readiness for Skupper operations.
- **Tests**: Confirms Kubernetes connectivity and required dependencies are present.

### **3. `generate_namespaces`**
- **Purpose**: Creates namespaces with a specified prefix to segment workloads and services.
- **Tests**: Validates namespace creation and naming conventions.

### **4. `install_skupper`**
- **Purpose**: Installs Skupper by applying CRDs and deploying the Skupper controller.
- **Tests**: Ensures that CRDs are applied and the Skupper controller is running.

### **5. `skupper_site`**
- **Purpose**: Configures Skupper sites with specific settings like `linkAccess`.
- **Tests**: Verifies that Skupper site manifests are correctly applied and pods are ready.

### **6. `expose_connector`**
- **Purpose**: Manages the creation and deployment of Skupper connectors for application routing.
- **Tests**: Validates connector configuration, application, and functionality.

### **7. `teardown_namespaces`**
- **Purpose**: Cleans up resources by removing namespaces and Skupper-related deployments.
- **Tests**: Verifies successful cleanup and resource deletion.

---

## Simplified Folder Structure

```plaintext
skupper-tests-playbook/
├── ansible.cfg               # Ansible configuration file
├── Makefile                  # Automates tasks like dependency installation
├── README.md                 # Documentation for the project
├── run_all_tests.sh          # Script to execute all role tests
├── test_results/             # Directory to store logs of role tests
├── scenarios/                # Example scenarios (e.g., hello-world/)
├── collections/              # Ansible collections with roles and tests
│   └── ansible_collections/
│       └── rhsiqe/
│           └── skupper/
│               ├── roles/
│               │   ├── deploy_workload/      # Deploys backend and frontend workloads
│               │   ├── env_shakeout/         # Prepares the environment
│               │   ├── generate_namespaces/  # Creates namespaces
│               │   ├── install_skupper/      # Installs Skupper
│               │   ├── skupper_site/         # Configures Skupper sites
│               │   ├── expose_connector/     # Creates and deploys Skupper connectors
│               │   └── teardown_namespaces/  # Removes namespaces and Skupper deployments
│               └── galaxy.yml                # Metadata for the collection
└── requirements.txt          # Python dependencies for the project
```

---

## Local Installation and Testing

### **1. Running All Tests**

To test all roles in sequence, including logging and teardown:

1. Install dependencies:
   ```bash
   make install
   ```
2. Run the test script:
   ```bash
   ./run_all_tests.sh
   ```
3. The script runs tests in the following order:
   - `generate_namespaces`
   - `deploy_workload`
   - `install_skupper`
   - `skupper_site`
   - `expose_connector`
   - `teardown_namespaces` (always last)

4. Logs for each role are saved in the `test_results/` directory. The script provides a summary output, e.g.:
   ```plaintext
   generate_namespaces................................. [PASSED]
   deploy_workload..................................... [PASSED]
   install_skupper..................................... [FAILED]
   skupper_site........................................ [SKIPPED] (No test_playbook.yml or inventory found)
   expose_connector.................................... [PASSED]
   teardown_namespaces................................. [PASSED]
   ```

   - **`[PASSED]`**: The role test succeeded.
   - **`[FAILED]`**: The role test failed (see logs for details).
   - **`[SKIPPED]`**: The role test was skipped due to missing files.

---

### **2. Testing Individual Roles**

To test a specific role:

1. Navigate to the role's `tests/` directory:
   ```bash
   cd collections/ansible_collections/rhsiqe/skupper/roles/<role_name>/tests/
   ```
2. Run the role's test playbook:
   ```bash
   ansible-playbook -i inventory/hosts.yml test_playbook.yml
   ```
3. Review the output for success or failure. For detailed logs, refer to `test_results/`.

---

## Example Scenarios

### **Hello-World Scenario**
- **Location**: `scenarios/hello-world/`
- **Purpose**: Demonstrates an end-to-end Skupper setup with backend and frontend connectivity.

#### Running the Scenario:
```bash
ansible-playbook -i scenarios/hello-world/inventory/hosts.yml scenarios/hello-world/hello-world.yml
```

---

## Compatibility

- **Tested with**: `ansible-lint >= 24.2.0`
- **Compatible with**: The latest stable version of `ansible-core`

---

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.