/etc/cloud/cloud.cfg.d/99-disable-network-config.cfg:
  file.managed:
    - source: salt://templates/99-disable-network-config.cfg
    - makedirs: True
/etc/network/interfaces.d/50-cloud-init:
  file.managed:
    - source: salt://templates/50-cloud-init.cfg
/etc/cloud/cloud-init.disabled:
  file.managed:
    - contents: ''

  