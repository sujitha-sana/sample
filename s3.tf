resource "aws_s3_bucket" "version"{
    bucket = "version-cicd-demo-pdtr"
    tags = {
        name = "version-cicd-demo-pdtr"
    }
  
}