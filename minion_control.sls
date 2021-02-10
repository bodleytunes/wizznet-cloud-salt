bootstrap_minion_install_pkg: 
    pkg.installed:
        - name: 'salt-minion'

/etc/salt/minion:
  file.managed:
    - source: salt://templates/minion_template.j2
    - template: jinja
#salt-minion:
#  service.running:
#    - name: salt-minion
#    - enable: True
#    - reload: True
#    - watch:
#      - file: /etc/salt/minion

restart_minion:
  cmd.run:
    - name: systemctl restart salt-minion

