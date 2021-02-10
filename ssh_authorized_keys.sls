AAAAC3NzaC1lZDI1NTE5AAAAIBNPXegfN6YaATTyrq9ow5didiMvG+CjOEzmK6+vWomH:
  ssh_auth.present:
    - user: jon
    - enc: ed25519
    - config: '%h/.ssh/authorized_keys'
