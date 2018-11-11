resource "aws_vpc" "first_tf_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags {
        Name = "terraform-aws-vpc"
    }
}

resource "aws_subnet" "subnet1" {
    tags {
        Name = "10.0.32.0 -us-east-1a"
    }
    cidr_block = "${cidrsubnet(aws_vpc.first_tf_vpc.cidr_block,3 ,1 )}"
    vpc_id = "${aws_vpc.first_tf_vpc.id}"
    availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet2" {
    tags {
        Name = "10.0.128.0 -us-east-1b"
    }
    cidr_block = "${cidrsubnet(aws_vpc.first_tf_vpc.cidr_block,2 , 2)}"
    vpc_id = "${aws_vpc.first_tf_vpc.id}"
    availability_zone = "us-east-1b"
}

resource "aws_security_group" "subnetsecurity" {
    vpc_id = "${aws_vpc.first_tf_vpc.id}"
    ingress {
        cidr_blocks = [
        "${aws_vpc.first_tf_vpc.cidr_block}"
        ]
        from_port = 80
        to_port = 80
        protocol = "tcp"
    }
}