Role Name
=========

Skupper Install

A brief description of the role goes here.

Requirements
------------

This role requires the following:
- Ansible 2.9 or higher
- Kubernetes cluster access
- `kubectl` configured to interact with the cluster

Role Variables
--------------

The following variables can be set for this role:

- `skupper_repository`: The repository URL for Skupper. Default is `https://github.com/skupperproject/skupper.git`.
- `skupper_branch`: The branch of the Skupper repository to use. Default is `v2`.
- `skupper_controller_manifest`: The URL for the Skupper controller manifest. Default is `https://raw.githubusercontent.com/skupperproject/skupper/v2/cmd/controller/deploy_cluster_scope.yaml`.

Dependencies
------------

This role has no dependencies on other roles.

Example Playbook
----------------

Here is an example of how to use this role:

  - hosts: servers
    roles:
     - role: skupper-install

License
-------

Apache License 2.0

Author Information
------------------

This role was created by the Skupper project maintainers. For more information, visit [Skupper.io](https://skupper.io).

Rafael Zago <rzago@redhat.com>
```