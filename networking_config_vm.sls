{% set hostvars = salt['pillar.get'](opts.id)  %}

# get rid of sh*tty netplan directory - GOOD RIDDANCE!
no_more_netplan:
  file.absent:
    - name: /etc/netplan

# install ifupdown (/etc/network/interfaces) and resolvconf (dns)
install_ifupdown:
  pkg.installed:
    - pkgs:
      - ifupdown
      - resolvconf

{# setup vm network interfaces #}
{% for interface in hostvars.networking %}
{{interface.name}}:
  network.managed:
    - enabled: True
    - ipaddr: {{interface.ip}}
    - netmask: {{interface.mask}}
{% if interface.gw is not none %}
    - gateway: {{interface.gw}}
{% endif %}
    - type: eth
    - proto: static
    - mtu: {{ interface.mtu }}
    - dns:
{% if interface.gw is not none %}
      - {{interface.gw}}
{% endif %}
      - 1.1.1.1
      - 9.9.9.9
      - 8.8.4.4
      - 8.8.8.8
{% endfor %}

#minion_file_control_vm:
#  file.managed:
#    - name: /etc/salt/minion
#    - source: salt://templates/minion_template_vm.j2
#    - template: jinja

#restart_minion:
#  cmd.run:
#    - name: systemctl restart salt-minion