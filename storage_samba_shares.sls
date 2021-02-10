{% set password = salt['pillar.get']('secrets:jon_smb') %}
{% set password_hash = salt['cmd.shell']('salt '+opts.id+' pdbedit.generate_nt_hash '+password)  %}

install_packages_samba:
  pkg.installed:
    - name: samba
install_packages_cifs:
  pkg.installed:
    - name: cifs-utils


/etc/samba/smb.conf:
  file.managed:
    - source: salt://templates/smb.j2
    - template: jinja

smbd:
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: install_packages_samba
    - watch:
      - file: /etc/samba/smb.conf

{# smb users
have to run the following first to get the nt hash ...
salt 'p21' pdbedit.generate_nt_hash my_new_smb_user_password_goes_here
 create jon #}
pdbedit.create:
  module.run:
    - login: jon
    - password: 630E085E6F643141ED18B4C4BA5F7003
    - password_hashed: True

    
