

variable "AWS_REGION" {    
    default = "us-east-1"
}

variable "AMI" {
    type = string
  default = "ami-054e49cb26c2fd312"
}
variable "public_key" {
  default = "~/.ssh/terraform-keypair.pub"
}

variable "private_key" {
  default = "terraform-keypair.pem"
}