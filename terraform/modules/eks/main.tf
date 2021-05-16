resource "aws_eks_cluster" "this" {
  count                     = var.create_eks ? 1 : 0
  name                      = var.cluster_name
  #enabled_cluster_log_types = var.cluster_enabled_log_types   # Need to work on later
  role_arn                  = var.cluster_iam_role_arn
  version                   = var.cluster_version
  tags                      = var.tags

  vpc_config {
    security_group_ids      = compact([var.cluster_security_group_id])
    subnet_ids              = var.subnets
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  timeouts {
    create = var.cluster_create_timeout
    delete = var.cluster_delete_timeout
  }

  dynamic "encryption_config" {
    for_each = toset(var.cluster_encryption_config)

    content {
      provider {
        key_arn = encryption_config.value["provider_key_arn"]
      }
      resources = encryption_config.value["resources"]
    }
  }

  # depends_on = [
  #   aws_security_group_rule.cluster_egress_internet,
  #   aws_security_group_rule.cluster_https_worker_ingress,
  #   aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  #   aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
  #   aws_iam_role_policy_attachment.cluster_AmazonEKSVPCResourceControllerPolicy,
  #   aws_cloudwatch_log_group.this
  # ]
}

resource "aws_security_group_rule" "cluster_private_access" {
  count       = var.create_eks && var.cluster_create_endpoint_private_access_sg_rule && var.cluster_endpoint_private_access ? 1 : 0
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = var.cluster_endpoint_private_access_cidrs

  security_group_id = aws_eks_cluster.this[0].vpc_config[0].cluster_security_group_id
}
