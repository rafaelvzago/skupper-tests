# Rhsiqe Skupper Collection

This repository contains the `rhsiqe.skupper` Ansible Collection, providing roles and modules to manage, test, and deploy Skupper environments in Kubernetes.

---

## Tested with Ansible

This collection has been tested with:
- **ansible-core >=2.14** 
- The current development version of ansible-core.

---

## External Requirements

Some modules and plugins require external libraries. Refer to the documentation of each role or module for specific dependencies.

---

## Included Content

The collection includes the following roles:

1. **`deploy_workload`**: Deploys workloads in Kubernetes namespaces.
2. **`env_shakeout`**: Validates the Kubernetes environment for Skupper.
3. **`generate_namespaces`**: Creates namespaces with defined naming conventions.
4. **`install_skupper`**: Installs Skupper by applying CRDs and its controller.
5. **`skupper_site`**: Configures Skupper sites with advanced settings.
6. **`create_connector`**: Deploys connectors for application routing.
7. **`access_grant`**: Manages access tokens for Skupper endpoints.
8. **`create_listener`**: Configures listeners for consuming services via Skupper.
9. **`link_site`**: Establishes site links between Skupper instances.
10. **`host_setup`**: Prepares hosts for Skupper deployment.
11. **`teardown_test`**: Cleans up Skupper resources and namespaces after testing.
12. **`expose_service`**: Exposes services in Kubernetes namespaces.
13. **`run_curl_test`**: Runs a test to validate Skupper connectivity.

For a detailed list of all content, visit the [Ansible Galaxy page for this collection](https://galaxy.ansible.com/rhsiqe/skupper).

---

## Using This Collection

### Installation

To install the collection from Ansible Galaxy, run:

```bash
ansible-galaxy collection install rhsiqe.skupper
```

### Using `requirements.yml`

You can include the collection in a `requirements.yml` file:

```yaml
collections:
  - name: rhsiqe.skupper
```

Install it via:

```bash
ansible-galaxy collection install -r requirements.yml
```

### Upgrading the Collection

To upgrade the collection to the latest available version:

```bash
ansible-galaxy collection install rhsiqe.skupper --upgrade
```

### Installing Specific Versions

To install a specific version (e.g., for compatibility or bug fixes):

```bash
ansible-galaxy collection install rhsiqe.skupper:==X.Y.Z
```

Replace `X.Y.Z` with any [available version](https://galaxy.ansible.com/rhsiqe/skupper).

For detailed information, refer to [Ansible Using Collections](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html).

---

## Release Notes

Refer to the [changelog](https://github.com/ansible-collections/REPONAMEHERE/tree/main/CHANGELOG.rst) for updates and release notes.

---

## Running Tests

### Role-Specific Testing

Each role includes its own dedicated test playbook. You can manually test a specific role. For example, to test the `access_grant` role:

```bash
ansible-playbook collections/ansible_collections/rhsiqe/skupper/roles/access_grant/tests/test_playbook.yml \
  -i collections/ansible_collections/rhsiqe/skupper/roles/access_grant/tests/inventory/hosts.yml
```

### Running All Tests

To run all tests in a logical order, use the `run_all_tests.sh` script. The script ensures dependencies between roles are respected and logs results for review.

```bash
make tests
```

Test logs are stored in the `test_results/` directory.

---

## Roadmap

- Further integration with advanced Skupper features.
- Automated testing for compatibility with future Ansible and Kubernetes releases.
- Performance testing roles and scenarios.

---

## More Information

For additional resources, refer to:
- [Ansible Collection Overview](https://github.com/ansible-collections/overview)
- [Ansible User Guide](https://docs.ansible.com/ansible/latest/user_guide/index.html)
- [Ansible Developer Guide](https://docs.ansible.com/ansible/latest/dev_guide/index.html)
- [Ansible Community Code of Conduct](https://docs.ansible.com/ansible/latest/community/code_of_conduct.html)
- [The Bullhorn (Ansible Contributor Newsletter)](https://docs.ansible.com/ansible/latest/community/communication.html#the-bullhorn)

---

## Licensing

This project is licensed under the [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0).
