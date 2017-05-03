#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-2df66d3b
#
# Your subnet ID is:
#
#     subnet-75a08610
#
# Your security group ID is:
#
#     sg-4cc10432
#
# Your Identity is:
#
#     testing-bee
#
terraform {
  backend "atlas" {
    name = "mattb/training"
  }
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.zones}"
}

resource "aws_instance" "web" {
  count			 = "2"
  ami                    = "ami-2df66d3b"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-75a08610"
  vpc_security_group_ids = ["sg-4cc10432"]

  tags {
    Identity = "testing-bee"
    Name = "mattb ${count.index + 1}"
    Org = "flux7"
  }
}


variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "zones" {
  default = "us-east-1"
}



output "public_dns" {
	value = ["${aws_instance.web.*.public_dns}"]
}
