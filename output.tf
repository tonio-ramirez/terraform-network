output "vpc_id" {
  value = "${aws_vpc.this.id}"
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "private_subnet_ids" {
  value = ["${aws_subnet.private.*.id}"]
}

output "azs" {
  value = ["${var.availability_zones}"]
}

output "natgw_ids" {
  value = ["${aws_nat_gateway.this.*.id}"]
}