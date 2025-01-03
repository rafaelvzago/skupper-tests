<!-- LOGO -->
<h1>
<p align="center">
  <img src="https://skupper.io/images/skupper-logo.svg" alt="Logo" width="128">
  <br>Skupper Tests
</h1>
  <p align="center">
    Modular and scalable framework to test and manage Skupper environments with Ansible.
    <br />
    <a href="#about">About</a>
    ·
    <a href="#documentation">Documentation</a>
    ·
    <a href="#getting-started">Getting Started</a>
    ·
    <a href="#roles">Roles</a>
    ·
    <a href="#scenarios">Scenarios</a>
  </p>
</p>

## About

Skupper Tests is a project designed to provide a modular and scalable framework to test and manage Skupper environments using Ansible. Each role focuses on a specific aspect of Skupper-based architecture, ensuring flexibility, reliability, and adherence to Ansible best practices. This project includes comprehensive tests for each role to maintain robustness.

---

## Documentation

Explore the full [documentation](https://rafaelvzago.github.io/skupper-tests/) for installation, role descriptions, testing instructions, and more.

---

## Getting Started

### Installing Dependencies

1. Install Python and Ansible dependencies:
   ```bash
   make build
   ```
2. Run the hello-world scenario:
   ```bash
   make hello
   ```
3. Review test results in the `test_results/` directory.

---

## Roles

Below is the list of roles included in this project:

- **[Access Grant](https://rafaelvzago.github.io/skupper-tests/roles/access_grant/)**: Manages access credentials for Skupper endpoints.
- **[Create Connector](https://rafaelvzago.github.io/skupper-tests/roles/create_connector/)**: Creates and deploys connectors for application routing in Skupper.
- **[Create Listener](https://rafaelvzago.github.io/skupper-tests/roles/create_listener/)**: Configures listeners for consuming services via Skupper.
- **[Deploy Job](https://rafaelvzago.github.io/skupper-tests/roles/deploy_job/)**: Deploys backend and frontend workloads in specified namespaces.
- **[Deploy Workload](https://rafaelvzago.github.io/skupper-tests/roles/deploy_workload/)**: Installs workloads and verifies readiness.
- **[Environment Shakeout](https://rafaelvzago.github.io/skupper-tests/roles/env_shakeout/)**: Validates and prepares the Kubernetes environment for Skupper.
- **[Expose Service](https://rafaelvzago.github.io/skupper-tests/roles/expose_service/)**: Exposes services for external access.
- **[Generate Namespaces](https://rafaelvzago.github.io/skupper-tests/roles/generate_namespaces/)**: Creates namespaces with specific naming conventions.
- **[Host Setup](https://rafaelvzago.github.io/skupper-tests/roles/host_setup/)**: Configures the host for Skupper operations.
- **[Install Skupper](https://rafaelvzago.github.io/skupper-tests/roles/install_skupper/)**: Installs Skupper by applying CRDs and deploying its controller.
- **[Link Site](https://rafaelvzago.github.io/skupper-tests/roles/link_site/)**: Establishes site links between Skupper instances.
- **[Run Curl](https://rafaelvzago.github.io/skupper-tests/roles/run_curl/)**: Validates Skupper connectivity and service availability.
- **[Skupper Site](https://rafaelvzago.github.io/skupper-tests/roles/skupper_site/)**: Configures Skupper sites with advanced settings.
- **[Teardown Test](https://rafaelvzago.github.io/skupper-tests/roles/teardown_test/)**: Cleans up namespaces and Skupper-related resources after testing.

---

## Scenarios

### Hello World Scenario

This scenario deploys a simple frontend and backend application in separate namespaces. The frontend consumes the backend service via Skupper, utilizing all the roles in the collection as a guide to create your own scenarios.

#### Running the Hello World Scenario

1. **Run the scenario:**
   ```bash
   ansible-playbook scenarios/hello-world/hello-world.yml -i scenarios/hello-world/inventory/hosts.yml
   ```

2. **Skip Skupper installation:**
   ```bash
   ansible-playbook scenarios/hello-world/hello-world.yml -i scenarios/hello-world/inventory/hosts.yml -e skip_skupper_install=true
   ```

3. **Skip teardown:**
   ```bash
   ansible-playbook scenarios/hello-world/hello-world.yml -i scenarios/hello-world/inventory/hosts.yml -e skip_teardown=true
   ```

---

## Compatibility

- **Tested with**: `ansible-lint >= 24.2.0`
- **Compatible with**: `ansible-core`

---

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.

