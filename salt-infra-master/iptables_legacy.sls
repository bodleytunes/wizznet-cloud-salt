switch_to_iptables_legacy:
  cmd.run:
    - name: |
        update-alternatives --set iptables /usr/sbin/iptables-legacy
        update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
        update-alternatives --set arptables /usr/sbin/arptables-legacy
        update-alternatives --set ebtables /usr/sbin/ebtables-legacy
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 300

