provider "aws" {
  region = "us-east-1"
}

variable "region" {
  type = "string"
}

variable "vpc_name" {
  type = "string"
}

variable "cidr_block" {
  type = "string"
}

module "base_networking" {
  source = "../../"
  vpc_name = "${var.vpc_name}"
  cidr_block = "${var.cidr_block}"
}