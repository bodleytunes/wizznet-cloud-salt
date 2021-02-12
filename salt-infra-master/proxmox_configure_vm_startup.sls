

vm_startup_delay_timer:
  cmd.run:
    - name: |
        qm set 101 --startup up=300
        qm set 201 --startup up=300
    - shell: /bin/bash
    - timeout: 300
