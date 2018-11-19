resource "aws_subnet" "subnet1" {
  tags {
    Name = "10.0.32.0 -us-east-1a"
  }
  cidr_block = "${cidrsubnet(aws_vpc.first_tf_vpc.cidr_block,3 ,1 )}"
  vpc_id = "${aws_vpc.first_tf_vpc.id}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"
}

resource "aws_subnet" "subnet2" {
  tags {
    Name = "10.0.128.0 -us-east-1b"
  }
  cidr_block = "${cidrsubnet(aws_vpc.first_tf_vpc.cidr_block,2 , 2)}"
  vpc_id = "${aws_vpc.first_tf_vpc.id}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"
}