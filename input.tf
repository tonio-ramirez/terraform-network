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