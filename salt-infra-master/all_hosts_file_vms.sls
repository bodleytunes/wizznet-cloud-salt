
{% set hostvars = salt['pillar.get'](opts.id)  %}

{# setup evpn peers #}
{% for item in hostvars.frr.evpn.peers %}
{{item.name}}:
  host.present:
    - ip: {{item.ip}}
{% endfor %}


p10:
  host.present: 
    - ip: 10.55.0.10
p12:
  host.present:
    - ip: 10.55.0.12
p75:
  host.present:
    - ip: 10.55.0.75
lm1:
  host.present:
    - ip: 10.12.10.7
salt:
  host.present:
    - ip: 86.29.22.70
salt.wizznet.co.uk:
  host.present:
    - ip: 86.29.22.70
127.0.1.1:
  host.only:
    - hostnames: []
localhost:
  host.present:
    - ip: 127.0.0.1

# disable stupid cloud config managed hosts file (to allow changes to persist)
/etc/cloud/cloud.cfg:
  file.append:
    - text: 'manage_etc_hosts: False'