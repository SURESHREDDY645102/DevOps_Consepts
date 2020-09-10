# Create a VPC=> Region
aws ec2 create-vpc --cidr-block 10.10.0.0/16
# vpc-0c6a39da2cc011386
# ctrl+shif+p
# Focus: Terminal
#
# Create atlest two subnets
# Subnet => AZ
aws ec2 create-subnet --cidr-block 10.10.0.0/24 --vpc-id vpc-0c6a39da2cc011386 --availability-zone us-east-1a
  subnet-0829a7ea1e9dad625

aws ec2 create-subnet --cidr-block 10.10.1.0/24 --vpc-id vpc-0c6a39da2cc011386 --availability-zone us-east-1b
  subnet-0db8df16df011a06e

aws ec2 create-subnet --cidr-block 10.10.2.0/24 --vpc-id vpc-0c6a39da2cc011386 --availability-zone us-east-1c
  subnet-00eb4be18706f503a

# Create a Internet gateway
  aws ec2 create-internet-gateway
    igw-0be96e203aef421ad
# Attach Internet gateway to vpc
 aws ec2 attach-internet-gateway --internet-gateway-id igw-0be96e203aef421ad --vpc-id vpc-0c6a39da2cc011386
# Create Routetable
  aws ec2 create-route-table --vpc-id vpc-0c6a39da2cc011386
    rtb-0581504488968f193
# Create  Routes to routetable with Internet gateway
  aws ec2 create-route --route-table-id rtb-0581504488968f193 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-0be96e203aef421ad
# Associate routetable with subnets
  aws ec2 associate-route-table --route-table-id rtb-0581504488968f193 --subnet-id subnet-0829a7ea1e9dad625
    "AssociationId": "rtbassoc-06681a9ab76fe3e02"

  aws ec2 associate-route-table --route-table-id rtb-0581504488968f193 --subnet-id subnet-0db8df16df011a06e
    rtbassoc-0c43f07fe3441a9cd

  aws ec2 associate-route-table --route-table-id rtb-0581504488968f193 --subnet-id subnet-00eb4be18706f503a
    rtbassoc-056a66033728868fb
# Create subnet group for RDS database
aws rds create-db-subnet-group --db-subnet-group-name "dbsubnet" --db-subnet-group-description "subnet group for database" --subnet-ids "subnet-0829a7ea1e9dad625" "subnet-0db8df16df011a06e" "subnet-00eb4be18706f503a" 
  "DBSubnetGroupName": "dbsubnet"
  "SubnetIdentifier": "subnet-00eb4be18706f503a"
# Create sql RDS database
aws rds create-db-instance --db-name "sureshdb" --db-instance-identifier "suresh-db-cli" --allocated-storage 20 --db-instance-class db.t2.micro --engine mysql --master-username suresh --master-user-password ABCabc123 --db-subnet-group-name dbsubnet
  "DBInstanceIdentifier": "suresh-db-cli"
  "MasterUsername": "suresh"
  "DBName": "sureshdb"
# Create security grp