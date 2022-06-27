#!/bin/bash

ip=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)

#run smts server
python3 smts/server/smts.py -p -el &

sleep 1

#run lemma_server
smts/build/lemma_server -s$ip:3000 &

#run solvers
mpirun --mca btl_tcp_if_include eth0 --allow-run-as-root -np 8 \
  --hostfile $1 --use-hwthread-cpus --map-by node:PE=2 --bind-to none --report-bindings \
  smts/build/solver_opensmt -s$ip:3000

#send instance
python3 smts/server/client.py 3000 $2