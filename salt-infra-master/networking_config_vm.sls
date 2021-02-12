{% set hostvars = salt['pillar.get'](opts.id)  %}
{% set public_interface_name = salt['network.default_route']('inet')[0]['interface']  %}

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

# change to legacy interface names via grub
change_to_legacy_iface_names:
  file.line:
    - name: /etc/default/grub
    - match: GRUB_CMDLINE_LINUX=""
    - content: GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"
    - mode: replace

# update grub
update_grub:
  cmd.run:
    - name: |
        sudo update-grub


{# setup vm network interfaces #}
{% for interface in hostvars.networking %}
{% if interface.gw is not none %}
{{ public_interface_name }}:
{% else %}
{{ interface.name }}:
{% endif %}
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