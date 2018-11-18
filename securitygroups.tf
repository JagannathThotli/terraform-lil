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

resource "aws_security_group" "allow-all" {
  vpc_id = "${aws_vpc.first_tf_vpc.id}"
  name="allow-all"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    protocol = "tcp"
    to_port = 6556
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "allow-RDP"
  }
}