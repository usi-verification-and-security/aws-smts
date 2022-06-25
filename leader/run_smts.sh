#!/bin/bash

ip=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)

#run smts server
python3 smts/server/smts.py -p &

#run lemma_server
smts/build/lemma_server -s$ip:3000 &

#run solvers
mpirun --mca btl_tcp_if_include eth0 --allow-run-as-root -np 1 \
  --hostfile $1 --use-hwthread-cpus --map-by node:PE=2 --bind-to none --report-bindings \
  smts/build/solver_opensmt -s$ip:3000 -mono=$2 -satsolver="c" -cbbs=1500 -cbdf="1.0" \
  -shufinp=0.03 -shufshcls=1 -slpp=$((50000000 * 4)) \
  -cfhl=300 -ihlbd=8 -islbd=8 -fhlbd=8 -fslbd=8 -smcl=30 -hmcl=30 \
  -s=1 -sleep=1000 -t=2 -appmode=thread -nolog "-v=2 -0o=1"