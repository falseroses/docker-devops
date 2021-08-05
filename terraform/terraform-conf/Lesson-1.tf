provider "aws" {}


resource "aws_instance" "my_Ubuntu" {
      ami = "ami-05f7491af5eef733a"
      instance_type = "t2.micro"
      tags = {
            Name = "Ubuntu Server 20.04"
      }
}

