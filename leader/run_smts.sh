#!/bin/bash

#run smts
python3 SMTS/server/smts.py -p -o60 -l &

sleep 1

#send instance
python3 SMTS/server/client.py 3000 $2
