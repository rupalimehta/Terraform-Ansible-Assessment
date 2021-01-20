variable "AWS_REGION" {    
    default = "us-east-1a"
}

variable "AMI" {
    type = string
  default = "ami-0885b1f6bd170450c"
}
variable "public_key" {
  default = "~/.ssh/terraform-keypair.pub"
}

variable "private_key" {
  default = "terraform-keypair.pem"
}