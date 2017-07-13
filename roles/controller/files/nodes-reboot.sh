#!/bin/bash

for i in 1 2 3 4; do
  nc -z p$i 22
  if [ $? -eq 0 ]; then
    ssh -f p$i sudo reboot
  fi
done
