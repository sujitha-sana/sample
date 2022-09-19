output "cicdip"{
    value = aws_instance.stage_cicd.public_ip
}

output "cicddns"{
    value = aws_instance.stage_cicd.public_dns
}

output "tomcatip"{
    value = aws_instance.stage_tomcat.public_ip
}

# output "cicdip"{
#     value = aws_instance.stage_cicd.public_ip
# }