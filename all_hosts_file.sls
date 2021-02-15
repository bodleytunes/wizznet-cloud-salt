
{% set hostvars = salt['pillar.get'](opts.id)  %}

{# setup evpn peers #}
{% for item in hostvars.frr.evpn.peers %}
{{item.name}}:
  host.present:
    - ip: {{item.ip}}
{% endfor %}

{{hostvars.hostname}}:
  host.present:
    - ip: {{hostvars.zt_ip}}


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
{% if opts.id == 'lm2' %}
    - ip: 10.12.7.149
{% else %}
    - ip: 86.29.22.70
{% endif %}
salt.wizznet.co.uk:
  host.present:
{% if opts.id == 'lm2' %}
    - ip: 10.12.7.149
{% else %}
    - ip: 86.29.22.70
{% endif %}
127.0.1.1:
  host.only:
    - hostnames: []
localhost:
  host.present:
    - ip: 127.0.0.1

mfsmaster:
  host.present:
    - ip: 10.55.0.20
chunkserver1:
  host.present:
    - ip: 10.55.0.20
metalogger_1:
  host.present:
    - name: metalogger
    - ip: 10.55.0.20
cgiserver_1:
  host.present:
    - name: cgiserver
    - ip: 10.55.0.20

shadowmaster:
  host.present:
    - ip: 10.55.0.21
chunkserver2:
  host.present:
    - ip: 10.55.0.21
metalogger_2:
  host.present:
    - name: metalogger
    - ip: 10.55.0.21
cgiserver_2:
  host.present:
    - name: cgiserver
    - ip: 10.55.0.21


