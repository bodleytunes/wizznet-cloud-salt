linux:
  storage:
    disk:
      first_drive:
        startsector: 1
        name: /dev/sdb
        type: gpt
        partitions:
          - size: 100% 
            type: zfs
      second_drive:
        startsector: 1
        name: /dev/sdc
        type: gpt
        partitions:
          - size: 100% 
            type: zfs
      third_drive:
        startsector: 1
        name: /dev/sdd
        type: gpt
        partitions:
          - size: 100% 
            type: zfs
      fourth_drive:
        startsector: 1
        name: /dev/sde
        type: gpt
        partitions:
          - size: 100% 
            type: zfs