resource "aws_security_group" "stage-docker-sg" {
  name        = "allow docker"
  description = "Allow docker inbound traffic"
  vpc_id      = "vpc-0859fa737a167cb13"

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    # security_groups = [aws_security_group.stage-bastion-sg.id]

  }

#   ingress {
#     description = "ssh from VPC"
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]

#   }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "Stage-docker-sg"
  }
}


resource "aws_instance" "stage_docker" {
  ami           = "ami-0b89f7b3f054b957e"
  instance_type = "t2.micro"
  #   vpc_id = aws_vpc.stage-vpc.id
  subnet_id              = "subnet-037191be97e63fda9"
  vpc_security_group_ids = [aws_security_group.cicd-sg.id]
  key_name               = aws_key_pair.localkey.id
  iam_instance_profile = aws_iam_instance_profile.version.name
#   user_data              = <<-EOF
#          #!/bin/bash
#          sudo yum install update -y
#          sudo yum install java -y
#          amazon-linux-extras install java-openjdk11
#          wget -O /opt/apache-docker-9.0.65-windows-x64.zip https://dlcdn.apache.org/docker/docker-9/v9.0.65/bin/apache-docker-9.0.65-windows-x64.zip
#          cd /opt
#          unzip apache-docker-9.0.65-windows-x64.zip
#          mv apache-docker-9.0.65 docker9
#          rm -f apache-docker-9.0.65-windows-x64.zip
#          EOF
  tags = {
    Name = "stage-docker"
  }
}