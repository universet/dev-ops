#!/bin/bash

num=0
while [[ $num -le 5 ]]
do
  echo "lol"
  num=$num+1
done

<<task
Print even numbers upto 10
task

i=0
echo "Even numbers upto 10 are: "
while [[ $i -le 10 ]]; do
  if [[ $((i % 2)) == 0 ]]; then
    echo $i
  fi
    i=$((i + 1))
done