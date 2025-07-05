provider "aws" {
  region = "ap-southeast-2"
}

module "ec2_instance" {
  source = "./module/ec2instance"
  instance_type_value = "t2.micro"
  subnet_id_value = "subnet-05ee15d0379ea865a"
  name = "bbb"
}
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-tf-test-bucket-deaw-veerapat-pirultham"
}

resource "aws_dynamodb_table" "terraform_lock" {
  name             = "terraform-lock"
  hash_key         = "LockID"
  billing_mode     = "PAY_PER_REQUEST"
  

  attribute {
    name = "LockID"
    type = "S"
  }


}
output "example" {
  value = module.ec2_instance.public-ip
}