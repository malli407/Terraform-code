variable "vpc_cidr" {}
variable "environment" {}
variable "public_subnets_cidr" {
    type = list(string)
}
variable "availability_zones" {
    type = list(string)
}
variable "private_subnets_cidr" {
    type = list(string)
}