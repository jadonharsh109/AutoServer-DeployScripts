provider "aws" {
  region = var.region
}

resource "aws_key_pair" "jenkins-key-pair" {
  key_name   = "jenkins-ssh-key"
  public_key = file("${path.module}/jenkins.pub")
}


resource "aws_security_group" "jenkins_security_group" {
  name        = "Jenkins_Security_group"
  description = "Jenkins_Security_group is created by Terraform"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [22, 8080]
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

resource "aws_instance" "jenkins_instance" {
  ami             = var.ubuntu_ami_id
  instance_type   = "t2.large"
  key_name        = aws_key_pair.jenkins-key-pair.key_name
  security_groups = ["${aws_security_group.jenkins_security_group.name}"]
  tags = {
    Name = "JenkinsServer"
  }

}

output "jenkins_public_ip" {
  value = aws_instance.jenkins_instance.public_ip
}
