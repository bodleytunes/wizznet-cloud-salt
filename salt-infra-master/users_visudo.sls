# include the sudo pkg install state so it can be referenced/checked by require
include:
  - sudo
  - groups_sudo_group

sudo.config_file:
  file.managed:
    - name: /etc/sudoers
    - user: root
    - group: root
    - mode: 0440
    - source: salt://templates/sudoers
    - template: jinja
    - check_cmd: /usr/sbin/visudo -c -f
  # make sure that sudo apt package is installed and that the group sudo is present on the machine
    - require:
      - sls: sudo
      - group: sudo