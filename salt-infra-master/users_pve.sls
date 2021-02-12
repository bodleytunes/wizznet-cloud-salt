create_user:
  cmd.run:
    - name: pveum user add terraform-prov@pve --password {{ salt['pillar.get']('secrets:terraform_pve_password') }} 
      
assign_role:
  cmd.run:
    - name: |
        pveum aclmod / -user terraform-prov@pve -role Administrator
