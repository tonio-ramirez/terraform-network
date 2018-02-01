provider "aws" {
  region = "us-east-1"
}

variable "vpc_name" {
  type = "string"
}

variable "cidr_block" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "public_subnet_cidr_blocks" {
  type = "map"
}

variable "private_subnet_cidr_blocks" {
  type = "map"
}

module "base_networking" {
  source = "../../"
  vpc_name = "${var.vpc_name}"
  cidr_block = "${var.cidr_block}"
  availability_zones = "${var.availability_zones}"
  public_subnet_cidr_blocks = "${var.public_subnet_cidr_blocks}"
  private_subnet_cidr_blocks = "${var.private_subnet_cidr_blocks}"
}

output "vpc_id" {
  value = "${module.base_networking.vpc_id}"
}

output "public_subnet_ids" {
  value = ["${module.base_networking.public_subnet_ids}"]
}

output "azs" {
  value = ["${module.base_networking.azs}"]
}

output "private_subnet_ids" {
  value = ["${module.base_networking.private_subnet_ids}"]
}

output "natgw_ids" {
  value = ["${module.base_networking.natgw_ids}"]
}