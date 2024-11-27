# Role: expose_service

The `expose_service` Ansible role automates the creation of Kubernetes `Service` resources to expose deployments within a cluster or to external clients. It supports various service types, including `ClusterIP`, `NodePort`, and `LoadBalancer`.

---

## Tasks

- **Set Namespace:**
  - Determines the namespace where the service will be created based on the prefix and name variables.
- **Expose Deployment:**
  - Creates or updates a Kubernetes `Service` to expose a deployment on the specified port.
- **Debug Service Creation Result:**
  - Outputs the result of the service creation for verification.

---

## Requirements

- Ansible 2.1 or newer
- `kubernetes.core` collection installed on the control node
- Kubernetes cluster accessible via `kubeconfig`

---

## Role Variables

| Variable                  | Default Value     | Description                                                                 |
|---------------------------|-------------------|-----------------------------------------------------------------------------|
| `expose_service_name`     | `frontend`        | Name of the service to expose.                                             |
| `expose_service_port`     | `8080`            | External port exposed by the service.                                      |
| `expose_service_target_port` | `8080`         | Target port on the deployment.                                             |
| `expose_service_type`     | `LoadBalancer`    | Service type (`ClusterIP`, `NodePort`, or `LoadBalancer`).                 |
| `namespace_prefix`        |                   | Prefix for the Kubernetes namespace.                                       |
| `namespace_name`          |                   | Name of the Kubernetes namespace.                                          |
| `kubeconfig`              |                   | Path to the kubeconfig file for accessing the Kubernetes cluster. **Mandatory.** |

---

## Example Usage

### Playbook

```yaml
- hosts: all
  tasks:
    - name: Expose a service in the specified namespace
      ansible.builtin.include_role:
        name: rhsiqe.skupper.expose_service
      vars:
        namespace_prefix: "skupper"
        namespace_name: "east"
        expose_service_name: "frontend"
        expose_service_port: 9090
        expose_service_target_port: 9090
        expose_service_type: "NodePort"
```

### Inventory (host_vars)

#### `east.yml`

```yaml
kubeconfig: /path/to/east/kubeconfig
namespace_prefix: "skupper"
namespace_name: "east"
```

#### `west.yml`

```yaml
kubeconfig: /path/to/west/kubeconfig
namespace_prefix: "skupper"
namespace_name: "west"
```

---

## Notes

- The namespace is derived as `<namespace_prefix>-<namespace_name>`.
- Ensure that the deployment selector matches the `app` label used in the `Service` definition.
- The role uses the `kubernetes.core.k8s` module, which requires the `kubernetes.core` collection to be installed.

---

## License

This project is licensed under the Apache License, Version 2.0. See the [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) for details.