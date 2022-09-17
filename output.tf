output "cicdip"{
    value = aws_instance.stage_cicd.public_ip
}

output "cicddns"{
    value = aws_instance.stage_cicd.public_dns
}