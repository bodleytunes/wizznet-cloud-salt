partition_check_sda:
  module.run:
    - name: partition.exists
    - device: /dev/sda4

partition_list_sda:
  module.run:
    - name: partition.list
    - device: /dev/sda
    - unit: GB

partition_create_sda:
  module.run:
    - name: partition.mkpart
    - device: /dev/sda4
    - part_type: primary