import json
import requests
from requests import NullHandler
from pathlib import Path
import pytest


def get_node_id(token):

    headers = {"X-ZT1-Auth": str(token)}

    if token is not None:
        response = requests.get("http://localhost:9993/status", headers=headers)
        data = response.json()
        return data
    return {}


@pytest.fixture
def token():
    return "V___Wp"


@pytest.fixture
def zt_network_id():
    return "1__81d"


@pytest.mark.zt_check_exists
def check_exists(token: str, zt_network_id: str):

    bearer = f"bearer {token}"
    headers = {"Content-Type": "application/json", "Authorization": bearer}
    url = f"https://my.zerotier.com/api/network/{zt_network_id}/member"

    # json_payload = {"config": {"authorized": authorize}}

    # full curl api example to central zerotier controller
    # curl -v -X POST https://my.zerotier.com/api/network/1_____d/member/64b124492d --header "Content-Type: application/json" --header "Authorization: bearer [secret-api-token-goes-here-fnowfjwnonf]" -d '{"config": {"authorized": true}}'

    if token or zt_network_id is not None:

        response_data = requests.get(url, headers=headers)
        # deserialize
        response_dict = response_data.json()

        if len(response_dict) > 0:
            for r in response_dict:
                new_url = ""
                match_nodes = ["p20", "p21"]
                for node in match_nodes:
                    if node in (r["description"] or r["name"]):
                        # delete entry
                        # curl -v -X DELETE -H 'X-ZT1-Auth: 62___5264a' http://localhost:9993/controller/network/2d___9ee/member/0123456789
                        new_url = url + "/" + r["nodeId"]
                        response = requests.delete(new_url, headers=headers)

    return


def set_authorize_node(token, zt_network_id, zt_node_id, authorize=True):

    # first delete any existing
    check_exists(token, zt_network_id)

    bearer = f"bearer {token}"
    headers = {"Content-Type": "application/json", "Authorization": bearer}
    url = f"https://my.zerotier.com/api/network/{zt_network_id}/member/{zt_node_id}"
    # note that the authorize variable has to be a boolean not a string
    json_payload = {"config": {"authorized": authorize}}

    # full curl api example to central zerotier controller
    # curl -v -X POST https://my.zerotier.com/api/network/1_____d/member/64b124492d --header "Content-Type: application/json" --header "Authorization: bearer [secret-api-token-goes-here-fnowfjwnonf]" -d '{"config": {"authorized": true}}'

    if token or zt_network_id or zt_node_id is not None:
        # serialize the json
        response = requests.post(url, headers=headers, data=json.dumps(json_payload))
        data = response.json()
        return data
    return {}


def set_ip(token, zt_network_id, zt_node_id, ip_address):

    bearer = f"bearer {token}"
    headers = {"Content-Type": "application/json", "Authorization": bearer}
    url = f"https://my.zerotier.com/api/network/{zt_network_id}/member/{zt_node_id}"

    # {% set script_final_line = "'{\"config\": {\"ipAssignments\": [\"" + hostvars.zt_ip +"\"]} }'" %}
    json_payload = {"config": {"ipAssignments": [str(ip_address)]}}

    if token or zt_network_id or zt_node_id is not None:
        response = requests.post(url, headers=headers, data=json.dumps(json_payload))
        data = response.json()
        return data
    return {}


def set_name(token, zt_network_id, zt_node_id, zt_name):

    bearer = f"bearer {token}"
    headers = {"Content-Type": "application/json", "Authorization": bearer}
    url = f"https://my.zerotier.com/api/network/{zt_network_id}/member/{zt_node_id}"

    json_payload = {"name": zt_name}

    if token or zt_network_id or zt_node_id is not None:
        # have to use json.dumps to correctly serialize the json otherwise it complains of "unmarshalled"
        response = requests.post(url, headers=headers, data=json.dumps(json_payload))
        data = response.json()
        return data
    return {}


def set_description(token, zt_network_id, zt_node_id, description):

    bearer = f"bearer {token}"
    headers = {"Content-Type": "application/json", "Authorization": bearer}
    url = f"https://my.zerotier.com/api/network/{zt_network_id}/member/{zt_node_id}"

    # {% set script_final_line = "'{\"config\": {\"ipAssignments\": [\"" + hostvars.zt_ip +"\"]} }'" %}
    json_payload = {"description": description}

    if token or zt_network_id or zt_node_id is not None:
        # have to use json.dumps to correctly serialize the json otherwise it complains of "unmarshalled"
        response = requests.post(url, headers=headers, data=json.dumps(json_payload))
        data = response.json()
        return data
    return {}


def get_auth_token():

    auth_file = Path("/var/lib/zerotier-one/authtoken.secret")

    if auth_file.is_file():
        # file exists
        file = open("/var/lib/zerotier-one/authtoken.secret", "r")
        token = file.readline()
        token_dict = dict(token=token)
        return token_dict

    else:
        return {}


def set_networks(token, zt_network_id, zt_node_id, networks, zt_subnet):

    bearer = f"bearer {token}"
    headers = {"Content-Type": "application/json", "Authorization": bearer}
    url = f"https://my.zerotier.com/api/network/{zt_network_id}"

    # networks = [{"target": "10.21.0.0/16", "via": "10.55.0.21"}, {"target": "10.31.0.0/16", "via": "10.55.0.21"}]

    if token or zt_network_id or zt_node_id or networks is not None:

        response_data = requests.get(url, headers=headers)
        response_dict = response_data.json()
        current_route_list = response_dict["config"]["routes"]
        updated_route_list = []
        # check if already routes in zt, if not then skip this loop
        if len(current_route_list) > 0:
            # append new routes to existing but check if they are already there and dont append / duplicate
            for net in networks:
                if net not in current_route_list:
                    current_route_list.append(net)
            # now updated route list should equal current_route_list
            updated_route_list = current_route_list
            # zt_subnet - check its there if its not then append it.
            if zt_subnet not in updated_route_list:
                updated_route_list.append(zt_subnet)

        else:
            updated_route_list = networks
            # Also add the missing ZT subnet
            updated_route_list.append(zt_subnet)

        json_payload = {"config": {"routes": updated_route_list}}

        response_update = requests.post(
            url, headers=headers, data=json.dumps(json_payload)
        )
        data = response_update.json()
        return data
    return {}


check_exists(token="V_Wp", zt_network_id="1_1d")