//AWS Account credential
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default	= "us-east-2"
}

variable "AWS_INSTANCE_TYPE" {
  default	= "t2.micro"
}

variable "AWS_INSTANCE_USERNAME" {
  default	= "ubuntu"
}

variable "AZ_ZONE" {
  type		= list(string)
}

//Ubuntu AMI
variable "AMIS" {
  type		 = map(string)
}

//SECURITY GROUP
variable "SECURITY_GROUP_NAME" {}
variable "SG_DESCRIPTION" {}
variable "VPC_ID" {}


//AWS KEY PAIR
variable "KEY_NAME" {
  default	= "aws_key"
}

variable "PATH_TO_PRIVATE_KEY" {}
