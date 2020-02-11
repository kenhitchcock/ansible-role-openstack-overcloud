ansible-role-openstack-overcloud
=========

> Red Hat Openstack overcloud installation.

Configures all the requirements for the overcloud installation.

Requirements
------------

Undercloud built.

Valid subscription to OpenStack. All repositories need to be enabled.
Recommend using my role for registering your systems to cdn or satellite.
ansible-role-redhat-register


Role Variables
--------------

Available variables are listed below, along with default values (see defaults/main.yml):

    # No are required to be overwirtten for now. defaults/main.yaml has variables set for basic installation. 

    # For a different version you will need to override the default variable.
      osp_version: 13


Future Releases
---------------

 - Add support for detailed undercloud.conf configuration.

License
-------

MIT

Author Information
------------------

Ken Hitchcock [Github](https://github.com/kenhitchcock)

