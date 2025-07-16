variable "ec2_type" {
  description = "ec2 type in aws instance"
  type = string
  default = "t2.micro"
}
variable "ec2_ami" {
  type = string
  default = "ami-010876b9ddd38475e"
}