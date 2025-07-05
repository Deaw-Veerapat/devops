terraform {
  backend "s3" {
    bucket = "my-tf-test-bucket-deaw-veerapat-pirultham"
    key    = "test/terraform.tfstate"
    region = "ap-southeast-2"
    dynamodb_table = "terraform-lock"
  }
}