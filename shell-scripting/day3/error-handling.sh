#!/bin/bash

function create_dir() {
  mkdir demo
}

create_dir

if ! create_dir ; then # if block for graceful exit
    echo "The code is being exited as the directory already exists"
    exit 1
fi

echo "This should not work because the code is interrupted"