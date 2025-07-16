variable "ec2_type" {
  description = "ec2 type in aws instance"
  type = string
  default = "t2.micro"
}
variable "ec2_ami" {
  type = string
  default = "ami-020cba7c55df1f615"
}