ssh_eno:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match:
      - state
      - comment
    - comment: "Allow SSH inbound"
    - connstate: NEW,ESTABLISHED,RELATED
    - in-interface: en*
    - dport: 22
    - protocol: tcp
    - sport: 1025:65535
    - save: True

ssh_vmbr:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match:
      - state
      - comment
    - comment: "Allow SSH inbound"
    - connstate: NEW,ESTABLISHED,RELATED
    - in-interface: vmbr*
    - dport: 22
    - protocol: tcp
    - sport: 1025:65535
    - save: True



https_proxmox:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match:
      - state
      - comment
    - comment: "Allow proxmox gui inbound"
    - connstate: NEW,ESTABLISHED,RELATED
    - in-interface: zt*
    - dport: 8006
    - protocol: tcp
    - sport: 1025:65535
    - save: True


# drop everything else
drop_eth:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: DROP
    - comment: "DROP EVERYTHING ELSE"
    - in-interface: eth*
    - save: True

# drop everything else
drop_vmbr:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: DROP
    - comment: "DROP EVERYTHING ELSE"
    - in-interface: vmbr0
    - save: True

# drop everything else
drop_eno:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: DROP
    - comment: "DROP EVERYTHING ELSE"
    - in-interface: eno*
    - save: True

# drop everything else
drop_ens:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: DROP
    - comment: "DROP EVERYTHING ELSE"
    - in-interface: ens*
    - save: True