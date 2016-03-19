ipaserver
=========

A simple, but fairly parameterized, role for setting up a FreeIPA server. Primarily tested on Fedora.

Requirements
------------

Only support CentOS and Redhat distro

Role Variables
--------------

There are 2 main variables that need to be provided external to the role that have no default. 

    ipaserver_admin_password
    ipaserver_dir_admin_password

The following variables are used by this role and values are defined in defaults/main.yml:

    ipaserver_base_command:     ipa-server-install -U
    ipaserver_configure_ssh: True
    ipaserver_configure_sshd: True
    ipaserver_dns_forwarder: 8.8.8.8
    ipaserver_domain: current OS domain       # All lowercase. Actual DNS domain.
    ipaserver_hbac_allow: True
    ipaserver_idstart: 5000
    ipaserver_idmax: False
    ipaserver_mkhomedir: True
    ipaserver_packages:
      - ipa-server
      - bind
      - bind-dyndb-ldap
    ipaserver_realm: current OS realm       # All caps. Better to match domain, but not required
    ipaserver_setup_dns: True
    ipaserver_setup_ntp: True
    ipaserver_ssh_trust_dns: True
    ipaserver_ui_redirect: True


Single master installation
----------------
ansible-playbook playbooks/XXX/ipaserver-master.yml --skip-tags prepare-replica

Master and multiple replica installation
----------------
ansible-playbook playbooks/XXX/ipaserver-master.yml 

Master and add additional replica
----------------
ansible-playbook playbooks/XXX/ipaserver-master.yml --tags prepare-replica 
