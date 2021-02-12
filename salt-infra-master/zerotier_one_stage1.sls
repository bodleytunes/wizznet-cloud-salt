{%- set zt_network_id = salt['pillar.get']('secrets:zt_network') -%}

include:
  - zerotier_one_install

zerotier_one_configure:
  cmd.run:
    - name: zerotier-cli join {{ zt_network_id }}
    - require:
      - sls: zerotier_one_install


