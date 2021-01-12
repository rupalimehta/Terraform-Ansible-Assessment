resource "aws_instance" "jenkins-ci" {
ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"
# VPC
    subnet_id = "${aws_subnet.public-subnet.id}"
# Security Group
    vpc_ssh_ids = ["${aws_security_group.ssh-allowed.id}"]
    vpc_jenkins_ids = ["${aws_security_group.jenkins-port.id}"]

# the Public SSH key
    key_name = "${aws_key_pair.terraform-keypair.id}"
# Ansible requires Python to be installed on the remote machine as well as the local machine.

  provisioner "remote-exec" {
    inline = ["sudo apt-get -qq install python -y"]
  }
    # This is where we configure the instance with ansible-playbook
  # Jenkins requires Java to be installed 
  provisioner "local-exec" {
command = "ansible-playbook -u ubuntu -i '${aws_instance.jenkins-ci.public_ip},' --private-key ${var.ssh_key_private} install_jenkins.yaml" 

  }
  # This is where we configure the instance with ansible-playbook
  provisioner "local-exec" {
   
   command = "ansible-playbook -i '${aws_instance.jenkins-ci.public_ip},' --private-key ${var.ssh_key_private} install_jenkins.yaml"

} 
}