#!/bin/bash
#now i AM giving the names through command line

#Instancenames=("mongodb" "catalouge" "web" "redis" "user" "cart" "mysql" "shipping" "rabbitmq" "payments" "dispatch")
Instancenames=$@
instance_Type=""
Imageid=ami-03265a0778a880afb
Securitygroup_id=sg-0512695d6d01b2c74
domain_name=devopsvani.online
for i in $@
do
    if [[ $i == "mongodb" || $i == "mysql" ]]
    then
        instance_Type="t3.micro"
    else
        instance_Type="t2.micro"
fi
echo "Creating $i....."
private_IpAdress=$(aws ec2 run-instances --image-id $Imageid --instance-type $instance_Type --security-group-ids $Securitygroup_id --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]"|jq -r '.Instances[0].PrivateIpAddress')
echo "Created $i : Ip Address : $private_IpAdress"

aws route53 change-resource-record-sets --hosted-zone-id Z00901702AI0X0PSLUZQF --change-batch '{
            "Comment": "CREATE",
            "Changes": [{
            "Action": "CREATE",
                        "ResourceRecordSet": {
                                    "Name": "'$i.$domain_name'",
                                    "Type": "A",
                                    "TTL": 300,
                                 "ResourceRecords": [{ "Value": "'$private_IpAdress'"}]
}}]
}'
#echo "$i"

done
