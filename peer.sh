#!/bin/bash
ip link add c1_eth0 type veth peer name c2_eth0
ip link set netns $1 dev c1_eth0
ip link set netns $2 dev c2_eth0
