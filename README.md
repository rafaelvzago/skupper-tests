# Skupper Tests Ansible Project

## Project Structure and Content

This project directory is structured following Ansible best practices, with modular roles, scenarios, and configurations designed for scalability, reusability, and effective testing of Skupper environments. It also includes tests for each role to ensure consistent functionality.

```plaintext
skupper-tests-playbook/
├── ansible.cfg
├── .ansible-lint
├── ansible-navigator.yml
├── collections/
│   ├── ansible_collections/
│   │   └── rhsiqe/
│   │       └── skupper/
│   │           ├── galaxy.yml
│   │           ├── README.md
│   │           └── roles/
│   │               ├── deploy_workload/
│   │               │   ├── defaults/
│   │               │   │   └── main.yml
│   │               │   ├── README.md
│   │               │   ├── tasks/
│   │               │   │   └── main.yml
│   │               │   └── tests/
│   │               │       ├── group_vars/
│   │               │       │   └── all.yml
│   │               │       ├── host_vars/
│   │               │       │   └── localhost.yml
│   │               │       ├── inventory/
│   │               │       │   └── hosts.yml
│   │               │       └── test_playbook.yml
│   │               ├── env_shakeout/
│   │               │   ├── defaults/
│   │               │   │   └── main.yml
│   │               │   ├── README.md
│   │               │   └── tasks/
│   │               │       └── main.yml
│   │               ├── generate_namespaces/
│   │               │   ├── defaults/
│   │               │   │   └── main.yml
│   │               │   ├── README.md
│   │               │   ├── tasks/
│   │               │   │   └── main.yml
│   │               │   └── tests/
│   │               │       ├── group_vars/
│   │               │       │   └── all.yml
│   │               │       ├── host_vars/
│   │               │       │   └── localhost.yml
│   │               │       ├── inventory/
│   │               │       │   └── hosts.yml
│   │               │       └── test_playbook.yml
│   │               ├── install_skupper/
│   │               │   ├── defaults/
│   │               │   │   └── main.yml
│   │               │   ├── README.md
│   │               │   ├── tasks/
│   │               │   │   └── main.yml
│   │               │   └── tests/
│   │               │       ├── group_vars/
│   │               │       │   └── all.yml
│   │               │       ├── host_vars/
│   │               │       │   └── localhost.yml
│   │               │       ├── inventory/
│   │               │       │   └── hosts.yml
│   │               │       └── test_playbook.yml
│   │               └── teardown_namespaces/
│   │                   ├── defaults/
│   │                   │   └── main.yml
│   │                   ├── README.md
│   │                   ├── tasks/
│   │                   │   └── main.yml
│   │                   └── tests/
│   │                       ├── group_vars/
│   │                       │   └── all.yml
│   │                       ├── host_vars/
│   │                       │   └── localhost.yml
│   │                       ├── inventory/
│   │                       │   └── hosts.yml
│   │                       └── test_playbook.yml
├── devfile.yaml
├── .gitignore
├── LICENSE
├── Makefile
├── README.md
├── requirements.txt
├── run_all_tests.sh
├── scenarios/
│   └── hello-world/
│       ├── hello-world.bkp.yml
│       ├── hello-world.yml
│       └── inventory/
│           ├── group_vars/
│           │   └── all.yml
│           ├── hosts.yml
│           └── host_vars/
│               ├── east.yml
│               └── west.yml
└── test_results/
    ├── deploy_workload_result.log
    ├── generate_namespaces_result.log
    ├── install_skupper_result.log
    └── teardown_namespaces_result.log
```

## Key Files and Directories

- **`collections/requirements.yml`**: Specifies required Ansible collections, ensuring compatibility and reproducibility.
- **`roles/`**: Contains modular roles under `ansible_collections/rhsiqe/skupper/roles`, each with tasks, default variables, and associated tests.
- **`scenarios/hello-world/`**: Provides an example scenario with inventory and playbooks for testing a Skupper setup.
- **`run_all_tests.sh`**: A script to execute all role tests and store results in the `test_results` directory.
- **`test_results/`**: Contains logs for test runs of each role.
- **`Makefile`**: Automates tasks like dependency installation and tagging releases.

## Testing Roles

Each role includes a `tests/` directory with:
- A dedicated `test_playbook.yml`.
- Host and group variables under `host_vars/` and `group_vars/`.
- An inventory file for running isolated tests.

### Running All Tests

To execute tests for all roles:

1. Ensure you have dependencies installed:
   ```bash
   make install
   ```

2. Run the test script:
   ```bash
   ./run_all_tests.sh
   ```

3. Logs for each role will be stored in the `test_results/` directory.

### Testing Individual Roles

To test a specific role:

1. Navigate to the role’s `tests/` directory.
2. Execute the `test_playbook.yml` using Ansible:
   ```bash
   ansible-playbook -i inventory/hosts.yml test_playbook.yml
   ```

## Compatibility

- Tested with `ansible-lint >= 24.2.0`.
- Compatible with the latest stable version of `ansible-core`.

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.

---

### Key Additions:
1. **Test Details**: Highlighted the `tests/` directory for each role, the `run_all_tests.sh` script, and individual role testing.
2. **Results Directory**: Included details on `test_results/` for logs.
3. **Streamlined Structure**: Matched the updated folder structure while maintaining clarity.