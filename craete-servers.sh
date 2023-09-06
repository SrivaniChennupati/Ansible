#!/bin/bash

Instancenames=("mongodb" "catalouge" "web" "redis" "user" "cart" "mysql" "shipping" "rabbitmq" "payments" "dispatch")

for i in "${Instancenames[@]}"
do
echo "$i"
done
