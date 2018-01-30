resource "aws_subnet" "private" {
  count = "${length(var.availability_zones)}"
  cidr_block = "${var.private_subnet_cidr_blocks[var.availability_zones[count.index]]}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  vpc_id = "${aws_vpc.this.id}"
  tags {
    Name = "${format("%s-%s-private-subnet", var.vpc_name, element(var.availability_zones, count.index))}"
  }
}