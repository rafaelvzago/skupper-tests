# Skupper Ansible Automation Project

This project uses Ansible to automate the setup of Skupper sites and the interconnection of services across namespaces. The playbooks and roles in this repository deploy a frontend and backend application across two Kubernetes namespaces, linking them via Skupper for cross-cluster communication.

## Project Structure

```plaintext
.
├── ansible.cfg               # Configuration file for Ansible
├── inventory
│   ├── group_vars
│   │   └── all.yml           # Variables applicable to all groups
│   └── hosts                 # Inventory file defining hosts
├── LICENSE.txt               # License information
├── playbooks
│   ├── files                 # YAML files with configurations for deployments
│   │   ├── backend-connector.yml
│   │   ├── east-site.yml
│   │   ├── frontend-listener.yml
│   │   └── west-site.yml
│   ├── hello-world.yml       # Main playbook for Skupper deployment
│   ├── roles                 # Roles for modularized tasks
│   │   ├── skupper-install   # Role for Skupper installation
│   │   └── skupper-link-sites # Role for linking Skupper sites
├── README.md                 # Project documentation
└── requirements.txt          # Dependencies for Ansible roles
```

## Playbooks

### `hello-world.yml`

This is the primary playbook that:
1. Installs Skupper.
2. Creates unique namespaces (e.g., `hello-world-west` and `hello-world-east`).
3. Deploys a frontend service in the west namespace and a backend service in the east namespace.
4. Applies Skupper configurations to both namespaces to enable cross-namespace communication.
5. Links the two Skupper sites using a custom role `skupper-link-sites`.
6. Exposes the frontend service to the outside world.
7. Validates the connectivity by curling the backend from the frontend namespace.

### Example Workflow

1. **Namespace Creation**: Creates randomized namespaces for isolating environments.
2. **Service Deployment**: Deploys the frontend and backend services into the respective namespaces.
3. **Skupper Configuration**: Applies Skupper configurations to enable communication between the namespaces.
4. **Connectivity Verification**: Runs a test to ensure backend service is accessible from the frontend.
5. **Tear Down**: Deletes namespaces and related resources post-run.

### Key Variables

- `images.frontend`: Docker image for the frontend application.
- `images.backend`: Docker image for the backend application.
- `source_namespace` and `target_namespace`: Variables used to specify namespaces in the Skupper link setup.

### Roles

#### `skupper-install`
Handles Skupper installation tasks, including configuration file management and necessary pre-requisites for Skupper.

#### `skupper-link-sites`
Links two Skupper sites by generating and using an access token, allowing cross-namespace communication.

## Dependencies

Install required roles listed in `requirements.txt` by running:

```bash
ansible-galaxy install -r requirements.txt
```

## Usage

1. **Setup Inventory**: Define the hosts and group variables in the `inventory` folder.
2. **Run the Playbook**:

    ```bash
    ansible-playbook -i inventory/hosts playbooks/hello-world.yml
    ```

This playbook will set up namespaces, deploy services, and link them through Skupper.

## Cleanup

To clean up resources, use the final teardown task in the `hello-world.yml` playbook, which deletes the created namespaces.

## License

This project is licensed under the terms in `LICENSE.txt`.

