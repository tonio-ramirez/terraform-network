resource "aws_subnet" "this" {
  count = "${length(var.availability_zones)}"
  cidr_block = "${var.subnet_cidr_blocks[var.availability_zones[count.index]]}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  vpc_id = "${aws_vpc.this.id}"
  tags {
    Name = "${format("%s-%s-subnet", var.vpc_name, element(var.availability_zones, count.index))}"
  }
}