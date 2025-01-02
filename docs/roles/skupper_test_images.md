Role Name
=========

This role introduces default values for the supporting images used for testing skupper.

Those values can be set as environment variables or overritten per host/or play.

The use of those variables in the roles and playbooks should:

- Allow an easy way to change images without need to changing code
- Centralize a list of images used by testing, in case they need maintenance

Requirements
------------

N/A

Role Variables
--------------

See defaults/main.yaml for the actual list.

They should all be self-descriptive and have the same function: point to an image on a registry.

Dependencies
------------

N/A

Example Playbook
----------------

Including the role will have the side-effect of setting the variables.

    - hosts: localhost
      roles:
         - { role: skupper_test_images }

License
-------

Apache

Author Information
------------------

hash-d
