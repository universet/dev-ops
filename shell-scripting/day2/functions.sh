#!/bin/bash

function is_loyal() { # this is function definition
    read -p "$1 ne piche mudke kise dekha: " girl
    if [ $girl == $2 ]; then
        echo "$1 is loyal"
    else
      echo "$1 is not loyal"
    fi
}

is_loyal Modiji Meloni # this is function call