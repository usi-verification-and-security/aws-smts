#!/bin/bash

#only works in linux
server_ip=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
totalNumberOfSolverInstances=$(($3*4))

#run smts server
python3 SMTS/server/smts.py &

sleep 1
#run lemma server
SMTS/build/lemma_server -s$server_ip:3000 &

#run solver clients
mpirun --mca btl_tcp_if_include eth0 --allow-run-as-root -np $totalNumberOfSolverInstances \
  --hostfile $1 --use-hwthread-cpus --map-by node:PE=4 --bind-to none --report-bindings \
  SMTS/build/solver_opensmt -s$server_ip:3000 &

#send instance
python3 SMTS/server/client.py 3000 $2

wait