variable "cluster_name" {
  type        = string
  description = "A name for the EKS cluster, and the resources it depends on"
}

variable "aws_auth_role_map" {
  default     = []
  description = "A list of mappings from aws role arns to kubernetes users, and their groups"
}

variable "aws_auth_user_map" {
  default     = []
  description = "A list of mappings from aws user arns to kubernetes users, and their groups"
}

variable "envelope_encryption_enabled" {
  type        = bool
  default     = true
  description = "Should Cluster Envelope Encryption be enabled, if changed after provisioning - forces the cluster to be recreated"
}

variable "vpc_config" {
  type = object({
    vpc_id             = string
    public_subnet_ids  = map(string)
    private_subnet_ids = map(string)
  })

  description = "The network configuration used by the cluster, If you use the included VPC module you can provide it's config output variable"
}