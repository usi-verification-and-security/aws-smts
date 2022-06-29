#!/bin/bash

#only works in linux
server_ip=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
#server_ip=$3

#run smts server
python3 SMTS/server/smts.py &

sleep 1
SMTS/build/lemma_server -s$server_ip:3000 &

#send instance
python3 SMTS/server/client.py 3000 $2

#run solvers
mpirun --mca btl_tcp_if_include eth0 --allow-run-as-root -np 2   --map-by node:PE=2 \
  --hostfile $1 SMTS/build/solver_opensmt -s$server_ip:3000
