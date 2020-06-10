# Simple EC2 instance with terraform

Create an EC2 instance using simple terraform code.

  - Generate a random key pair for EC2
  - Save .pem key to local directory
  - Create a Security Group with default VPC
  - Create an EC2 instance
  - Connect to created EC2 and run provision script ( nginx )


### Add terraform.tfvars

Create **terraform.tfvars** with the following keys and replace variables.

```
AWS_ACCESS_KEY      = "ADD AWS_ACCESS_KEY HERE"
AWS_SECRET_KEY      = "ADD AWS_SECRET_KEY HERE"
AWS_REGION          = "ADD AWS_REGION"
AZ_ZONE             = ["us-east-2a", "us-east-2b", "us-east-2c"]
AMIS                = {"us-east-1" = "ami-13be557e", "us-east-2" = "ami-0769e4bb31e1db8e4", "us-west-1" = "ami-0d729a60"}

AWS_INSTANCE_TYPE       = "t2.micro"
AWS_INSTANCE_USERNAME   = "ubuntu"

KEY_NAME                = "test_key"
PATH_TO_PUBLIC_KEY      = "test_key.pub"
PATH_TO_PRIVATE_KEY     = "test_key"

SECURITY_GROUP_NAME     = "test_grp"
SG_DESCRIPTION          = "Allow traffic for testing"
VPC_ID                  = "ADD DEFAULT VPC ID HERE"
```

### Build EC2 instance
Run following terraform commands to create EC2.
```
terraform init
terraform plan
terraform apply -auto-approve
```
