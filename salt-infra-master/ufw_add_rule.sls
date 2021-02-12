
{# ufw before rules (NAT rules) #}
/etc/ufw/before.rules:
  file.managed:
    - source: salt://templates/fw_ufw_before_rules.j2
    - template: jinja
{# inbound control plane rules (INPUT Rules) #}
ufw_rules:
  cmd.run:
    - onchanges:
      - file: /etc/ufw/before.rules 
    - names:
      - iptables -t nat -F && ufw reload && systemctl restart salt-minion

#ufw:
#  service.running:
#    - reload: True