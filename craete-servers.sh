#!/bin/bash

Instancenames=("mongodb" "catalouge" "web" "redis" "user" "cart" "mysql" "shipping" "rabbitmq" "payments" "dispatch")
instance_Type=""
for i in "${Instancenames[@]}"
do
if [[ $i == "mongodb" || $i == "mysql" ]]
then
instance_Type="t3.micro"
else
instance_Type="t2.micro"
fi
private_IpAdress=$(aws ec2 run-instances --image-id ami-03265a0778a880afb --instance-type $instance_Type --security-group-ids sg-0512695d6d01b2c74|jq -r '.Instances[0].PrivateIpAddress')
#echo "$i"

done
