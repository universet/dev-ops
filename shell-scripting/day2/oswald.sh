#!/bin/bash

<< comment
This is Oswald's world file
multi line comment is here
1. Variables
2. Arguments
comment

name="Oswald"

echo "My name is ${name}, and date is $(date)" # date is a command - command should be inside parenthesis

echo "Enter your name:"

read username

echo "You entered ${username}"

read -p "Enter last name: " lastname

echo "Hello, ${username} ${lastname}"

sudo useradd -m "${username}" # create user
echo "Created user ${username}"
cat /etc/passwd # to check if user is created
echo "---------------------------------------------------------------------------"

sudo deluser "${username}" # delete user
echo "Deleted user ${username}"
cat /etc/passwd
echo "---------------------------------------------------------------------------"

echo "The arguments are $0, $1, $2"