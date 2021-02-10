evpn0:
  network.managed:
    - enabled: True
    - ipaddr: 10.0.0.1
    - netmask: 255.255.255.0
    - type: bridge
    - proto: static
    - bridge: evpn0
    - delay: 10
    - ports: vxlan100
    - bypassfirewall: True
    - mtu: 1350
evpn1:
  network.managed:
    - enabled: True
    - ipaddr: 10.1.1.1
    - netmask: 255.255.255.0
    - type: bridge
    - proto: static
    - bridge: evpn1
    - delay: 10
    - ports: vxlan101
    - bypassfirewall: True
    - mtu: 1350