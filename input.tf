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