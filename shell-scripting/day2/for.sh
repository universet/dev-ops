#!/bin/bash

# this is for and while loops

for ((i = 1; i <= 5; i++));
do
  mkdir "demo${i}"
done

rm -rf demo*

<< task
$1 is argument 1 which is folder name
$2 is start range
$3 is end range
script can be ran as ./for.sh tej 01 03
task

for (( i = ${2}; i <= ${3}; i++ ))
do
  mkdir "${1}${i}"
done

rm -rf "${1}"*