resource "aws_subnet" "public" {
  count = "${length(var.availability_zones)}"
  cidr_block = "${var.public_subnet_cidr_blocks[var.availability_zones[count.index]]}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  vpc_id = "${aws_vpc.this.id}"
  tags {
    Name = "${format("%s-%s-public-subnet", var.vpc_name, element(var.availability_zones, count.index))}"
  }
}

resource "aws_internet_gateway" "this" {
  count = "${length(var.availability_zones) > 0 ? 1 : 0}"
  vpc_id = "${aws_vpc.this.id}"
  tags {
    Name = "${format("%s-igw", var.vpc_name)}"
  }
}

resource "aws_route_table" "public_route_table" {
  count = "${length(var.availability_zones) > 0 ? 1 : 0}"
  vpc_id = "${aws_vpc.this.id}"
  tags {
    Name = "${format("%s-public-route-table", var.vpc_name)}"
  }
}

resource "aws_route" "public_route" {
  count = "${length(var.availability_zones) > 0 ? 1 : 0}"
  route_table_id = "${aws_route_table.public_route_table.id}"
  gateway_id = "${aws_internet_gateway.this.id}"
  destination_cidr_block = "0.0.0.0/0"
  depends_on = ["aws_route_table.public_route_table"]
}

resource "aws_route_table_association" "public_route_table_association" {
  count = "${length(var.availability_zones)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
}