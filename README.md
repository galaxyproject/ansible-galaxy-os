This Ansible role is for configuring the base operating system useful for
running Galaxy.

Requirements
------------
The role has been developed and tested on Ubuntu 14.04. It requires `sudo` access.

Dependencies
------------
None

Role variables
--------------
All of the listed variables are stored in `defaults/main.yml`. Individual variables
can be set or overridden by setting them directly in a playbook for this role
(see an example below for `galaxy_user_uid`). Alternatively, they can be set by
creating `group_vars` directory in the root directory of the playbook used to
execute this role and placing a file with the variables there. Note that the
name of this file must match the value of `hosts` setting in the corresponding
playbook (e.g., `os-builder` for the sample playbook provided below).

 - `galaxy_user_name`: (default: `galaxy`) system username to be used for
    Galaxy
 - `galaxy_user_uid`: (default: `1001`) UID for the `galaxy_user_name`

### Control flow variables ###
The following variables can be set to either `yes` or `no` to indicate if the
given part of the role should be executed:
 - `install_packages`: (default: `yes`) install system level packages
 - `install_maintainance_packages`: (default: `yes`) install convenience system
    packages used for server maintenance and administration
 - `configure_docker`: (default: `yes`) configure Docker as part of `install_packages`
 - `apt_package_state`: (default: `latest`) set to `present` to not force update
    of existing installed packages.
 - `add_system_users`: (default: `yes`) configure system level users

Example playbook
----------------
To use the role, clone this repo and create a `hosts` file in the root repo dir
with access information for the target machine, for example:

    [os-builder]
    130.56.250.204 ansible_ssh_private_key_file=key.pem ansible_ssh_user=ubuntu

Next, create a `playbook.yml` file, setting any variables as desired:

    - hosts: os-builder
      become: yes
      tasks:
        - include: tasks/main.yml
          galaxy_user_uid: 1055

Run the playbook with:

    $ ansible-playbook playbook.yml -i hosts -e "@defaults/main.yml"
