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