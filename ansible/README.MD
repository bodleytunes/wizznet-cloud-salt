#### How to run this playbook to deploy root ssh keys to all proxmox hosts

First navigate to the root of the ansible working directory / repo
then run:

`ansible-playbook deploy-sshkeys.yml -i inventory.ini -vvv`