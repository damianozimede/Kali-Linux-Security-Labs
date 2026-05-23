#!/bin/bash


echo "Enter desired password length:"
read length
password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%' | head -c $length)
echo "Generated password: $password"
