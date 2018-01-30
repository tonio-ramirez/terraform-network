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

variable "subnet_cidr_blocks" {
  type = "map"
}

module "base_networking" {
  source = "../../"
  vpc_name = "${var.vpc_name}"
  cidr_block = "${var.cidr_block}"
  availability_zones = "${var.availability_zones}"
  subnet_cidr_blocks = "${var.subnet_cidr_blocks}"
}