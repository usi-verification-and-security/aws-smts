#!/bin/bash

#run smts with 60 solver instance and lemma sharing
python3 SMTS/server/smts.py -p -o60 -l &

sleep 1

#send instance
python3 SMTS/server/client.py 3000 $1
