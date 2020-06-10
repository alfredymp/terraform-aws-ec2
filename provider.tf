provider "aws" {
  version	= "2.12.0"
  access_key	= var.AWS_ACCESS_KEY
  secret_key	= var.AWS_SECRET_KEY
  region	= var.AWS_REGION
}
