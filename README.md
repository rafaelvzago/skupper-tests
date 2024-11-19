# Skupper Tests Ansible Project

## Overview

This project is designed to test and manage Skupper environments using Ansible roles and scenarios. Each role is modular and includes dedicated tests to ensure consistent functionality. The structure adheres to Ansible best practices, enabling scalability, reusability, and ease of testing.

---

## Key Roles

### **1. `deploy_workload`**
- **Purpose**: Deploys backend and frontend workloads in specified namespaces.
- **Tests**: Verifies workloads are deployed and running in Kubernetes.

### **2. `env_shakeout`**
- **Purpose**: Checks the environment for readiness before executing Skupper-related operations.
- **Tests**: Ensures Kubernetes and required tools are accessible.

### **3. `generate_namespaces`**
- **Purpose**: Creates namespaces with a specified prefix to segment workloads and services.
- **Tests**: Validates namespace creation and checks correct naming conventions.

### **4. `install_skupper`**
- **Purpose**: Installs Skupper by applying CRDs and deploying the Skupper controller.
- **Tests**: Confirms CRDs are applied and the Skupper controller is running.

### **5. `teardown_namespaces`**
- **Purpose**: Removes namespaces and cleans up Skupper-related resources.
- **Tests**: Validates the successful deletion of namespaces and associated resources.

### **6. `skupper_site`**
- **Purpose**: Configures Skupper sites with site-specific settings like `linkAccess`.
- **Tests**: Verifies Skupper site manifests and validates pod readiness.

---

## Simplified Folder Structure

```plaintext
skupper-tests-playbook/
├── ansible.cfg               # Ansible configuration file
├── Makefile                  # Automates common tasks
├── README.md                 # Project documentation
├── run_all_tests.sh          # Script to execute all role tests
├── scenarios/                # Contains example scenarios (e.g., hello-world/)
├── collections/              # Ansible collections for modular roles
│   └── ansible_collections/
│       └── rhsiqe/
│           └── skupper/
│               ├── roles/
│               │   ├── deploy_workload/      # Deploys workloads
│               │   ├── env_shakeout/         # Checks environment readiness
│               │   ├── generate_namespaces/  # Creates namespaces
│               │   ├── install_skupper/      # Installs Skupper
│               │   ├── skupper_site/         # Configures Skupper sites
│               │   └── teardown_namespaces/  # Deletes namespaces
│               └── galaxy.yml                # Metadata for the collection
├── test_results/             # Logs for role tests
└── requirements.txt          # Python dependencies
```

---

## Local install

### **1. Running All Tests**

To test all roles, use the provided script:

1. Install dependencies:
   ```bash
   make build
   ```
---

## Testing Roles

### **1. Running All Tests**

To test all roles in the correct order, including logging and teardown:

1. Install dependencies:
   ```bash
   make install
   ```
2. Run all tests with the provided script:
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
4. Logs for each role test are saved in the `test_results/` directory, and the script outputs a summary in the format:
   ```plaintext
   generate_namespaces................................. [PASSED]
   deploy_workload..................................... [PASSED]
   install_skupper..................................... [FAILED]
   skupper_site........................................ [SKIPPED] (No test_playbook.yml or inventory found)
   ```

   - **`[PASSED]`**: The role test succeeded.
   - **`[FAILED]`**: The role test failed (details provided in the logs).
   - **`[SKIPPED]`**: The role test was skipped due to missing files.

5. Review detailed logs in the `test_results/` directory for debugging.

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
3. Observe the output to confirm whether the role test passed or failed. For detailed logs, refer to the output in your terminal.

---

## Scenarios

### Example: **Hello-World Scenario**
- Location: `scenarios/hello-world/`
- Contains:
  - **`inventory/`**: Host and group variables for east and west environments.
  - **`hello-world.yml`**: Playbook that integrates multiple roles.

### Running the Scenario:
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

