provider "aws" {
  region = var.region
}

resource "aws_key_pair" "sonarqube-key-pair" {
  key_name   = "sonarqube-ssh-key"
  public_key = file("${path.module}/sonarqube.pub")
}


resource "aws_security_group" "sonarqube_security_group" {
  name        = "Sonarqube_Security_group"
  description = "Sonarqube_Security_group is created by Terraform"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [22, 8081, 9000]
    iterator = port

    content {
      description      = "Rule by Terraform"
      from_port        = port.value
      to_port          = port.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_instance" "sonarqube_instance" {
  ami             = var.ubuntu_ami_id
  instance_type   = "t2.medium"
  key_name        = aws_key_pair.sonarqube-key-pair.key_name
  security_groups = ["${aws_security_group.sonarqube_security_group.name}"]
  tags = {
    Name = "SonarQubeServer"
  }

}

output "sonarqube_public_ip" {
  value = aws_instance.sonarqube_instance.public_ip
}
