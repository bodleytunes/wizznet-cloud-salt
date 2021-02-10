ssh:
  nftables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match:
      - state
      - comment
    - comment: "Allow SSH inbound"
    - connstate: NEW,ESTABLISHED,RELATED
    - in-interface: zt*
    - dport: 22
    - protocol: tcp
    - sport: 1025:65535
    - save: True




