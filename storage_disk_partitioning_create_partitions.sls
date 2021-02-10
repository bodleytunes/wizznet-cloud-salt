{% set hostvars = salt['pillar.get'](opts.id) %}

#partition_check_sda:
#  module.run:
#    - name: partition.exists
#    - device: /dev/sda4
#
#partition_list_sda:
#  module.run:
#    - name: partition.list
#    - device: /dev/sda
#    - unit: GB

partition_create_sda5:
  module.run:
    - name: partition.mkpart
    - device: /dev/sda5
    - part_type: primary

partition_create_sdb4:
  module.run:
    - name: partition.mkpart
    - device: /dev/sdb4
    - part_type: primary

partition_create_sdc4:
  module.run:
    - name: partition.mkpart
    - device: /dev/sdc4
    - part_type: primary

partition_create_sdd4:
  module.run:
    - name: partition.mkpart
    - device: /dev/sdd4
    - part_type: primary