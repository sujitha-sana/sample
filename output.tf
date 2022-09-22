

# output "cicddns"{
#     value = aws_instance.stage_cicd.public_dns
# }

output "tomcatip"{
    value = aws_instance.dev_tomcat.public_ip
}

output "cicdip"{
    value = aws_instance.dev_cicd.public_ip
}

output "dockerip"{
    value = aws_instance.dev_docker.public_ip
}