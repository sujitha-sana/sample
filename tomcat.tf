resource "aws_security_group" "stage-tomcat-sg" {
  name        = "allow tomcat"
  description = "Allow tomcat inbound traffic"
  vpc_id      = "vpc-0859fa737a167cb13"

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    # security_groups = [aws_security_group.stage-bastion-sg.id]

  }

  ingress {
    description = "ssh from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "Stage-tomcat-sg"
  }
}


resource "aws_instance" "stage_tomcat" {
  ami           = "ami-0b89f7b3f054b957e"
  instance_type = "t2.micro"
  #   vpc_id = aws_vpc.stage-vpc.id
  subnet_id              = "subnet-037191be97e63fda9"
  vpc_security_group_ids = [aws_security_group.cicd-sg.id]
  key_name               = aws_key_pair.localkey.id
  #iam_instance_profile = aws_iam_instance_profile.artifactory.name
  # user_data              = <<-EOF
  #        #!/bin/bash
  #        wget -O /etc/yum.repos.d/jenkins.repo \
  #           https://pkg.jenkins.io/redhat-stable/jenkins.repo
  #        rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
  #        yum update -y
  #        # Add required dependencies for the jenkins package
  #        amazon-linux-extras install java-openjdk11
  #        yum install jenkins -y
  #        systemctl start jenkins
  #        systemctl enable jenkins
  #        EOF
  tags = {
    Name = "stage-tomcat"
  }
}
# resource "aws_instance" "stage_apache" {
#   ami           =  "ami-0b89f7b3f054b957e"
#   instance_type = "t2.micro"
# #   vpc_id = aws_vpc.stage-vpc.id
#   subnet_id = "subnet-037191be97e63fda9"
#   vpc_security_group_ids = [aws_security_group.stage-tomcat-sg.id]
#   key_name               = aws_key_pair.localkey.id
#   tags = {
#     Name = "stage-tomcat"
#   }
# }


# resource "aws_instance" "stage_Apache" {
#   ami           =  "ami-0b89f7b3f054b957e"
#   instance_type = "t2.micro"
# #   vpc_id = aws_vpc.stage-vpc.id
#   subnet_id = aws_subnet.stage-public[0].id
#   vpc_security_group_ids = [aws_security_group.stage-apache-sg.id]
#   tags = {
#     Name = "stage-Apache"
#   }
# }


# resource "aws_instance" "stage_Grafana" {
#   ami           =  "ami-0b89f7b3f054b957e"
#   instance_type = "t2.micro"
# #   vpc_id = aws_vpc.stage-vpc.id
#   subnet_id = aws_subnet.stage-public[0].id
#   vpc_security_group_ids = [aws_security_group.stage-apache-sg.id]
#   tags = {
#     Name = "stage-Grafana"
#   }
#  }
# }

# lifecycle {
#     create_before_destroy = true
#   }
