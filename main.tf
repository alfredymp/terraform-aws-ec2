resource "tls_private_key" "key_generate" {
	algorithm	= "RSA"
	rsa_bits	= 4096
}

resource "aws_key_pair" "aws_key" {
	key_name	= var.KEY_NAME
	public_key	= tls_private_key.key_generate.public_key_openssh
}

resource "local_file" "pem_key" {
	content 	= tls_private_key.key_generate.private_key_pem
	file_permission	= "0400"
	filename	= "${var.PATH_TO_PRIVATE_KEY}.pem"
}

resource "random_shuffle" "az" {
	input 		= var.AZ_ZONE
	result_count	= 1
}

resource "aws_security_group" "security_grp" {
	name		= var.SECURITY_GROUP_NAME
	description	= var.SG_DESCRIPTION
	vpc_id		= var.VPC_ID

	ingress {
	  from_port	= 80
	  to_port 	= 80
	  protocol 	= "tcp"
  	  cidr_blocks	= ["0.0.0.0/0"]
	}

	ingress {
	  from_port	= 22
	  to_port 	= 22
	  protocol 	= "tcp"
  	  cidr_blocks	= ["0.0.0.0/0"]
  	}

	egress {
	  from_port 	= 0
	  to_port	= 65535
  	  protocol 	= "tcp"
  	  cidr_blocks	= ["0.0.0.0/0"]
	}
}

resource "aws_instance" "first_ec2" {
	ami			= var.AMIS[var.AWS_REGION]
        instance_type		= var.AWS_INSTANCE_TYPE
        key_name 		= aws_key_pair.aws_key.key_name
        availability_zone	= random_shuffle.az.result[0]
        vpc_security_group_ids	= [aws_security_group.security_grp.id]

	provisioner "file" {
		source		= "script.sh"
		destination	= "/tmp/script.sh"
	}
	
	provisioner "remote-exec" {
		inline		= [
	 	  "chmod +x /tmp/script.sh",
  	 	  "sudo /tmp/script.sh"
		]
	}

	connection {
		host		= coalesce(self.public_ip, self.private_ip) //coalesce taks any number of list args and returns the first one that isn't empty.
		type		= "ssh"
		user		= var.AWS_INSTANCE_USERNAME
		private_key	= tls_private_key.key_generate.private_key_pem
	}
}
