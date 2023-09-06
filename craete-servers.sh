#!/bin/bash

Instancenames=("mongodb" "catalouge" "web" "redis" "user" "cart" "mysql" "shipping" "rabbitmq" "payments" "dispatch")
instance_Type=""
Imageid=ami-03265a0778a880afb
Securitygroup_id=sg-0512695d6d01b2c74
for i in "${Instancenames[@]}"
do
if [[ $i == "mongodb" || $i == "mysql" ]]
then
instance_Type="t3.micro"
else
instance_Type="t2.micro"
fi
private_IpAdress=$(aws ec2 run-instances --image-id $Imageid --instance-type $instance_Type --security-group-ids $Securitygroup_id|jq -r '.Instances[0].PrivateIpAddress')
echo "Created $i : Ip Address : $private_IpAdress"
#echo "$i"

done
