# import parted

# Import Salt libs
import salt
import salt.utils.path
import salt.utils.platform
from salt.exceptions import CommandExecutionError


# def __virtual__():
#    return __virtualname__


# get a list of all devices

# get a list of all partitions on particular device
def get_partitions(device: str) -> dict:
    # __salt__ = None
    salt.modules
    # partition_list = parted_partition.list_(device=device, unit="GB")
    partition_list = __salt__["parted_partition.list_"](device=device, unit="GB")
    # partition_list = parted.

    if partition_list:
        return partition_list

    return {}


# get next free partition number
def get_new_partition_id(device: dict) -> int:

    partition_list = len(get_partitions(device))

    if len(partition_list) > 0:
        return len(partition_list) + 1

    return None


# create partition with that particular id
def create_partition(device: dict, part_number: int, start: int) -> dict:
    parted_partition.mkpart(device=device, part_type="primary", start=1)
    return {}


def main(block_device: str) -> dict:
    partition_list = get_partitions(block_device)
    # get last partition
    last_part = partition_list.keys([-1])
    last_part_end = last_part["end"]
    last_part_end_split = last_part_end.split("GB", 2)
    new_part_num = last_part["number"] + 1
    new_part_start = int(last_part_end_split[0]) + 1
    create_partition(
        device=block_device, part_number=new_part_num, start=new_part_start
    )

    return {}


main(block_device="/dev/sde")