# Hello World Scenario

This `hello-world` scenario is an example Ansible setup to deploy, connect, and test a distributed application using Skupper. The scenario includes a backend deployed in the east site and a frontend deployed in the west site, connected via Skupper's networking capabilities.

## Project Structure

```plaintext
hello-world
├── hello-world.yml
└── inventory
    ├── group_vars
    │   └── all.yml
    ├── hosts.yml
    └── host_vars
        ├── east.yml
        └── west.yml
```

### Key Components
1. **Playbook** (`hello-world.yml`):
   - Configures hosts and performs environment setup, Skupper installation, workload deployment, connectivity testing, and resource cleanup.
2. **Inventory**:
   - `group_vars/all.yml`: Global variables shared across hosts.
   - `host_vars/east.yml` & `host_vars/west.yml`: Host-specific configurations.

## Playbook Overview

### Tasks
- **Host Setup**: Prepares the localhost environment.
- **Environment Shakeout**: Ensures the environment is ready for deployment.
- **Skupper Installation**: Installs Skupper on both sites.
- **Workload Deployment**:
  - Backend (east site).
  - Frontend (west site).
- **Connectivity Configuration**:
  - Connects the backend to the frontend using Skupper sites, connectors, and listeners.
- **Testing**:
  - Validates communication between the frontend and backend using a curl test.

### Roles
- `rhsiqe.skupper.host_setup`: Configures the host.
- `rhsiqe.skupper.install_skupper`: Installs Skupper.
- `rhsiqe.skupper.deploy_workload`: Deploys backend and frontend workloads.
- `rhsiqe.skupper.link_site`: Links Skupper sites for communication.

## Variables

### Global Variables (`group_vars/all.yml`)
- `ansible_connection`: Defines the connection type (local).
- `namespace_prefix`: Prefix for namespace names.
- `debug`: Enables debug output.

### East Site Variables (`host_vars/east.yml`)
- `namespace_name`: `hello-world-east`.
- Deployment details for the backend application.
- Connector configuration for exposing the backend.

### West Site Variables (`host_vars/west.yml`)
- `namespace_name`: `hello-world-west`.
- Deployment details for the frontend application.
- Listener configuration for consuming the backend service.
- Service exposure settings for the frontend.

## Usage

1. **Setup the Environment**:
   Ensure all dependencies are installed, including Ansible and required roles.

2. **Run the Playbook**:
   ```bash
   ansible-playbook -i inventory/hosts.yml hello-world.yml
   ```

3. **View Results**:
   - Check the deployed workloads.
   - Verify connectivity between the sites.

## Cleanup

The scenario includes a teardown step to delete all test resources, ensuring a clean state for subsequent tests.

## Notes

- This scenario demonstrates Skupper's ability to connect services across distributed sites.
- Adjust variables in `inventory` as needed to customize for your environment.

## Contributing

Contributions are welcome! Feel free to fork the repository and submit a pull request.

## License

This project is licensed under the [Apache 2.0 License](LICENSE).

