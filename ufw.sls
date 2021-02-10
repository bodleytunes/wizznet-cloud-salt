/etc/default/ufw:
  file.managed:
    - source: salt://templates/fw_ufw_defaults.j2
    - template: jinja

#/etc/ufw/ufw.conf:
#  file.append:
#    - text: DEFAULT_FORWARD_POLICY="ACCEPT"

{# ufw before rules (NAT rules) #}
/etc/ufw/before.rules:
  file.managed:
    - source: salt://templates/fw_ufw_before_rules.j2
    - template: jinja
{# inbound control plane rules (INPUT Rules) #}
ufw_rules:
  cmd.run:
    - names:
      - ufw allow ssh
      - ufw allow 9993/udp
      - ufw allow in on zt+
      - ufw allow in on lxdbr+
      - ufw allow in on evpn+
      - ufw enable 
      - iptables -t nat -F && ufw reload


ufw:
  service.running:
    - enable: True
    - reload: True