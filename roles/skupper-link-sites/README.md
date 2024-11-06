# Skupper Link Sites Role

The `skupper-link-sites` role enables cross-namespace or cross-cluster communication between Skupper sites by creating and applying `AccessGrant` and `AccessToken` resources. This role sets up secure connections between namespaces, facilitating service connectivity across clusters in a Skupper environment.

## Role Structure

```plaintext
skupper-link-sites
├── defaults
│   └── main.yml               # Default variables for site linking
├── files
│   └── access-grant.yml       # Template for AccessGrant resource
├── handlers
│   └── main.yml               # Handlers (if needed)
├── meta
│   └── main.yml               # Role metadata
├── tasks
│   └── main.yml               # Main tasks for linking Skupper sites
├── templates
│   └── access_token.yaml.j2   # Template for AccessToken resource
└── vars
    └── main.yml               # Variables specific to site linking
```

## Role Variables

The following variables can be configured in the playbook or in a group/host variable file:

- `source_namespace`: Namespace where the AccessGrant is created.
- `target_namespace`: Namespace where the AccessToken is applied.
- `access_grant_name`: Name for the AccessGrant resource.
- `access_token_name`: Name for the AccessToken resource.
- `access_token_template`: Path to the AccessToken YAML template, typically `templates/access_token.yaml.j2`.

## Tasks Overview

### 1. Ensuring `kubectl` Availability

Checks if `kubectl` is installed and available on the system, failing if not found.

### 2. Applying AccessGrant in the Source Namespace

Creates the `AccessGrant` resource in the specified `source_namespace` using the `access-grant.yml` file.

### 3. Waiting for AccessGrant to be Ready

Waits until the `AccessGrant` resource is ready, allowing it to generate the required connection details.

### 4. Retrieving AccessGrant Details

Fetches the status of the `AccessGrant` to extract information needed for creating the `AccessToken`, such as the CA, code, and URL.

### 5. Generating the AccessToken YAML

Uses the `access_token.yaml.j2` template to create the `AccessToken` YAML, populated with values from the `AccessGrant` status.

### 6. Applying AccessToken in the Target Namespace

Applies the generated `AccessToken` YAML in the specified `target_namespace`, linking it to the source.

### 7. Cleaning Up Temporary Files

Deletes the temporary `AccessToken` YAML file from the system after use.

## Example Usage

To use this role in a playbook, include it as follows:

```yaml
- name: Link Skupper sites between namespaces
  hosts: all
  roles:
    - role: skupper-link-sites
      vars:
        source_namespace: "namespace-a"
        target_namespace: "namespace-b"
        access_grant_name: "my-grant"
        access_token_name: "my-access-token"
        access_token_template: "templates/access_token.yaml.j2"
```

## Debugging and Verification

The role provides detailed debug messages for the status of the `AccessGrant` and the variables used to generate the `AccessToken`, aiding in troubleshooting.

## License

This project is licensed under the terms in `LICENSE.txt`.
