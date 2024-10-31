# Skupper Tests Ansible Project

This project, **skupper-tests**, is an Ansible automation setup designed to create namespaces across multiple Kubernetes clusters. It utilizes Ansible playbooks and roles to manage Kubernetes resources using the `kubernetes.core` collection.

## Project Structure

```
skupper-tests/
├── ansible.cfg               # Ansible configuration file
├── inventory/
│   ├── hosts                 # Inventory file listing clusters
│   └── group_vars/
│       └── all.yml           # Group variables (kubeconfig paths)
├── playbooks/
│   ├── hello-world.yml       # Main playbook to run namespace creation
│   └── test.yml              # Playbook to test connectivity to clusters
├── roles/
│   └── namespace-create/
│       └── tasks/
│           └── main.yml      # Role tasks for namespace creation
├── README.md                 # Project documentation (this file)
└── requirements.txt          # Python package requirements
```

## Prerequisites

- **Ansible**: Installed on your local machine.
- **Python Packages**: Install required Python packages using the provided `requirements.txt`.
  ```bash
  pip install -r requirements.txt
  ```
- **Kubernetes Collection**: Install the `kubernetes.core` Ansible collection.
  ```bash
  ansible-galaxy collection install kubernetes.core
  ```
- **Kubeconfig Files**: Access to Kubernetes clusters with valid kubeconfig files.

## Setup

### 1. Clone the Repository

Clone the `skupper-tests` project to your local machine:

```bash
git clone https://github.com/yourusername/skupper-tests.git
cd skupper-tests
```

### 2. Configure Inventory

Edit the `inventory/hosts` file to list your Kubernetes clusters:

```ini
[k8s_clusters]
ocp416
ocp417

[k8s_clusters:vars]
ansible_user=your_username
ansible_connection=local
```

### 3. Configure Group Variables

Edit `inventory/group_vars/all.yml` to specify the paths to your kubeconfig files:

```yaml
kubeconfigs:
  ocp416: "/home/your_username/.kube/ocp416"
  ocp417: "/home/your_username/.kube/ocp417"
```

Ensure that the cluster names (`ocp416`, `ocp417`) match those in your `hosts` file.

### 4. Ansible Configuration

Ensure `ansible.cfg` is present with the following content:

```ini
[defaults]
roles_path = ./roles
```

This tells Ansible where to find your roles.

## Usage

### 1. Test Connectivity to Clusters

Before running the main playbook, you can test connectivity to your clusters:

```bash
ansible-playbook -i inventory/hosts playbooks/test.yml
```

This playbook uses the `kubernetes.core.k8s_cluster_info` module to validate connections.

### 2. Create Namespaces

Run the `hello-world.yml` playbook to create namespaces on all clusters:

```bash
ansible-playbook -i inventory/hosts playbooks/hello-world.yml
```

This playbook will:

- Generate a unique namespace name for each cluster.
- Create the namespace using the `namespace-create` role.
- Save the namespace details and run ID to a YAML file in `playbooks/test_runs/`.

### 3. Verify Namespaces

Check that the namespaces have been created:

```bash
kubectl --kubeconfig=/home/your_username/.kube/ocp416 get namespaces
kubectl --kubeconfig=/home/your_username/.kube/ocp417 get namespaces
```

### 4. Review Run Details

The playbook saves run details in `playbooks/test_runs/namespace_run_<run_id>.yaml`.

Example content:

```yaml
run_id: '12345'
namespaces:
  - cluster: ocp416
    namespace: test-678-ocp416
  - cluster: ocp417
    namespace: test-910-ocp417
```

## Project Details

### Playbooks

- **playbooks/test.yml**: Tests connectivity to all clusters using the `kubernetes.core.k8s_cluster_info` module.
- **playbooks/hello-world.yml**: Executes the `namespace-create` role to create namespaces and saves run details.

### Role: namespace-create

Located in `roles/namespace-create/`, this role:

- Generates a random namespace name per cluster.
- Creates the namespace on each cluster.
- Collects namespace details for reporting.

#### Key Tasks in `roles/namespace-create/tasks/main.yml`:

1. **Generate Namespace Name**:
   ```yaml
   - name: Generate random suffix for each cluster's namespace
     vars:
       suffix: "{{ 1000 | random | string | regex_replace('^[^a-z0-9]*([a-z0-9]+)', '\\1') }}"
     set_fact:
       namespace_name: "test-{{ suffix }}-{{ inventory_hostname | lower }}"
   ```

2. **Create Namespace**:
   ```yaml
   - name: Create namespace for each cluster
     kubernetes.core.k8s:
       kubeconfig: "{{ kubeconfigs[inventory_hostname] }}"
       api_version: v1
       kind: Namespace
       state: present
       name: "{{ namespace_name }}"
     register: namespace_creation
   ```

3. **Collect Namespace Data**:
   ```yaml
   - name: Collect namespace details in host-specific variable
     set_fact:
       host_namespace_data:
         cluster: "{{ inventory_hostname }}"
         namespace: "{{ namespace_name }}"
   ```

### Variables

- **kubeconfigs**: A dictionary mapping cluster names to kubeconfig paths, defined in `inventory/group_vars/all.yml`.
- **run_id**: A unique identifier for each playbook run, generated at runtime.

## Troubleshooting

- **Undefined Variable Error**: Ensure variables are defined before use. Check task ordering in playbooks and roles.
- **Connection Issues**: Verify kubeconfig paths and permissions. Test connectivity manually using `kubectl`.
- **Python Interpreter Warnings**: Suppress warnings by adding `interpreter_python = auto_silent` to `ansible.cfg`.

  ```ini
  [defaults]
  interpreter_python = auto_silent
  ```

## Additional Tips

- **Consistency**: Ensure hostnames in `inventory/hosts` match keys in `kubeconfigs`.
- **Permissions**: Kubeconfig files should be readable by the user running Ansible.
- **Debugging**: Use `-vvv` with `ansible-playbook` for verbose output.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License.

## Contact

For questions or feedback, please open an issue in the repository.

---

**Note**: Replace `/home/your_username/.kube/ocp416` with the actual paths to your kubeconfig files.