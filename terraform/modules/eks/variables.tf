variables "create_eks" {
    default = "1"
}
variables "cluster_name" {
    default = "eks-cluster"
} 
variables "cluster_enabled__log_types" {}
variables "cluster_iam_role_arn" {}
variables "cluster_version" {}
variables "tags" {}
variables "cluster_security_group_id" {}
variables "subnets" {}
variables "cluster_endpoint_private_access" {}
variables "cluster_endpoint_public_access" {}
variables "cluster_endpoint_public_access_cidrs" {}
variables "cluster_service_ipv4_cidr" {}
variables "cluster_create_timeout" {}
variables "cluster_delete_timeout" {}
variables "cluster_encryption_config" {} 
  