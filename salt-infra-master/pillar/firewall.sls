firewall:
  enable: true
  install: true
  strict: true
  services:
    ssh:
      block_nomatch: true
      ips_allow:
        - 0.0.0.0/0

