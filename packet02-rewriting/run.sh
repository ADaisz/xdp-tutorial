#! /bin/bash

#   Assignment01
sudo ../testenv/testenv.sh setup --legacy-ip --name veth-packet02

make && sudo ./xdp_loader --dev veth-packet02 --auto-mode --force

#fc00:dead:cafe:2::1 :use 'ip a' check dev veth-packet02
sudo tcpdump -n -e -XX -i veth-packet02 & time sudo ip netns exec veth-packet02 sh -c "sleep 1 ; echo 'foo' | socat - 'udp6:[fc00:dead:cafe:2::1]:2000' ; killall tcpdump"