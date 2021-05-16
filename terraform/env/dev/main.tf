# terraform {
#     required_version = "~> 0.12.7"

#     backend "s3" {
#         bucket = "gaian-tf-state"
#         key = "ap-south-1/tenant-vpcs/vpc-1/terraform.tfstate"
#         region = "ap-south-1"
#     }
# }

provider "aws" {
  version = "~> 2.0"
  region = "ap-south-1"
  }

locals {
  region = "ap-south-1"
  environment = "dev"
}
# module "networking" {
#   source = "../../modules/network/vpc"
#   environment          = "${local.environment}"
#   vpc_cidr             = "10.0.0.0/16"
#   public_subnets_cidr  = ["10.0.1.0/24"]
#   private_subnets_cidr = ["10.0.2.0/24"]
#   availability_zones   = ["ap-south-1a","ap-south-1b"]
# }

module "vpc" {
  source = "../../modules/vpc"
  name               = "${local.environment}-vpc"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["ap-south-1a", "ap-south-1b"]
}

module "eks" {
  source               = "../../eksstack"
  vpc_config             = module.vpc.config
  cluster_name      = "${local.environment}-eks-cluster"
}