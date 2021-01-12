
resource "aws_vpc" "terraform-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    enable_classiclink = "false"
    instance_tenancy = "default"   
    
    tags {
        Name = "terraform-vpc"
    }
}
#creating public subnet for above VPC-ID
resource "aws_subnet" "public-subnet" {
    vpc_id = "${aws_vpc.terraform-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-1"
    tags {
        Name = "terraform-public-subnet"
    }
}

#creating Internet gateway for VPC
resource "aws_internet_gateway" "terraform-igw" {
    vpc_id = "${aws_vpc.terraform-vpc.id}"
    tags {
        Name = "terraform-igw"
    }
}
#creating Route Table
resource "aws_route_table" "terraform-route-table" {
    vpc_id = "${aws_vpc.terraform-vpc.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.terraform-igw.id}" 
    }
    
    tags {
        Name = "public-crt"
    }
}
resource "aws_route_table_association" "terraform-crta-public-subnet"{
    subnet_id = "${aws_subnet.public-subnet.id}"
    route_table_id = "${aws_route_table.terraform-route-table.id}"
}
