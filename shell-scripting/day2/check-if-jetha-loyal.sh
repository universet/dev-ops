#!/bin/bash

<< disclaimer
This is for infotainment purpose
disclaimer

read -p "Jetha ne mudke kise dekha: " girl
read -p "Jetha ka pyar: " pyar

if [[ $girl == "daya" ]];
then
  echo "Jetha is loyal"
elif [[ $pyar -ge 100 ]];
then
  echo "Jetha is loyal"
else
  echo "Jetha is not loyal"
fi