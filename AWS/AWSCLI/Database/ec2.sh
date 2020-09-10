# aws configure
# Create a VPC=> Region
aws ec2 create-vpc --cidr-block 10.10.0.0/16
# vpc-0df86eb3a777dff51
# ctrl+shif+p
# Focus: Terminal
#
# Create atlest two subnets
# Subnet => AZ
aws ec2 create-subnet --cidr-block 10.10.0.0/24 --vpc-id vpc-0df86eb3a777dff51 --availability-zone us-east-1a
  subnet-0f4dc6061aa4e2745
aws ec2 create-subnet --cidr-block 10.10.1.0/24 --vpc-id vpc-0df86eb3a777dff51 --availability-zone us-east-1b
  subnet-099f30551b9130d1f 
aws ec2 create-subnet --cidr-block 10.10.2.0/24 --vpc-id vpc-0df86eb3a777dff51 --availability-zone us-east-1c
  subnet-0cb285a4218b100a5
# Create a Internet gateway
  aws ec2 create-internet-gateway
    igw-05424b5cac6615bdf
# Attach Internet gateway to vpc
 aws ec2 attach-internet-gateway --internet-gateway-id igw-05424b5cac6615bdf --vpc-id vpc-0df86eb3a777dff51
# Create Routetable
  aws ec2 create-route-table --vpc-id vpc-0df86eb3a777dff51
    rtb-01fddae23bef4ddd2
# Create  Routes to routetable with Internet gateway
  aws ec2 create-route --route-table-id rtb-01fddae23bef4ddd2 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-05424b5cac6615bdf
# Associate routetable with subnets
  aws ec2 associate-route-table --route-table-id rtb-01fddae23bef4ddd2 --subnet-id subnet-0f4dc6061aa4e2745

  aws ec2 associate-route-table --route-table-id rtb-01fddae23bef4ddd2 --subnet-id subnet-099f30551b9130d1f 

  aws ec2 associate-route-table --route-table-id rtb-01fddae23bef4ddd2 --subnet-id subnet-0cb285a4218b100a5

# Create security group

aws ec2 create-security-group --group-name "sureshsecuritygrp" --vpc-id vpc-0df86eb3a777dff51 --description "ec2 securitygroup"
  # "GroupId": "sg-0db89e979038e20b0"

# authorize Ingress(inbound) rules to port 80,22
 
aws ec2 authorize-security-group-ingress --group-id "sg-0db89e979038e20b0" --protocol tcp --port 80 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress --group-id "sg-0db89e979038e20b0" --protocol tcp --port 22 --cidr 0.0.0.0/0

# Create(run) ec2(ubuntu) machine 
aws ec2 run-instances --image-id ami-07ebfd5b3428b6f4d --instance-type t2.micro --key-name privatepublicsubnets --security-group-ids sg-0db89e979038e20b0 --subnet-id subnet-0cb285a4218b100a5 --count 1 --associate-public-ip-address

  # image is: ami-07ebfd5b3428b6f4d
  # Instance id: i-07e78d35432b01b51
  # Key name: privatepublicsubnets
  # owner id: 447782355463
  # Reservation id: r-05499db574174c625
  # public ip: 34.229.238.169
# Create ec2 image
 aws ec2 create-image --instance-id i-07e78d35432b01b51 --name myami
  "ImageId": "ami-0e82e8b191be0bd28"