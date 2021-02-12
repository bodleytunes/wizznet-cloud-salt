
curl -v -X POST https://my.zerotier.com/api/network/{{zt_network_id}}/member/{{zt_member_id}} --header "Content-Type: application/json" --header "Authorization: bearer {{token}}" -d '{{ script_final_line }}'

