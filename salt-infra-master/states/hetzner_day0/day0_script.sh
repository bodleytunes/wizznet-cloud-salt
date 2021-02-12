#!/bin/bash

set -x

salt-ssh -i p20 state.apply states.hetzner_day0.day0_phase1
salt-ssh -i p21 state.apply states.hetzner_day0.day0_phase1
salt-key -d p20 -y
salt-key -d p21 -y
salt-ssh -i p20 state.apply states.hetzner_day0.day0_phase2
salt-ssh -i p21 state.apply states.hetzner_day0.day0_phase2
salt-key -a p20 -y
salt-key -a p21 -y

salt 'p2*' state.apply states.hetzner_day0.day0_phase3
salt 'p2*' state.apply states.hetzner_day0.day0_phase4_zt1
salt 'p2*' state.apply states.hetzner_day0.day0_phase5_zt2
salt 'p2*' state.apply states.hetzner_day0.day0_phase6_proxmox
salt 'p2*' state.apply states.hetzner_day0.day0_phase7
salt 'p2*' state.apply states.hetzner_day0.day0_phase8