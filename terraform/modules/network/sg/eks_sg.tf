resource "aws_security_group" "cluster" {
  count       = var.cluster_create_security_group && var.create_eks ? 1 : 0
  name_prefix = var.cluster_name
  description = "EKS cluster security group."
  vpc_id      = var.vpc_id
  tags = merge(
    var.tags,
    {
      "Name" = "${var.cluster_name}-eks_cluster_sg"
    },
  )
}

resource "aws_security_group_rule" "cluster_egress_internet" {
  count             = var.cluster_create_security_group && var.create_eks ? 1 : 0
  description       = "Allow cluster egress access to the Internet."
  protocol          = "-1"
  security_group_id = local.cluster_security_group_id
  cidr_blocks       = var.cluster_egress_cidrs
  from_port         = 0
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "cluster_https_worker_ingress" {
  count                    = var.cluster_create_security_group && var.create_eks ? 1 : 0
  description              = "Allow pods to communicate with the EKS cluster API."
  protocol                 = "tcp"
  security_group_id        = local.cluster_security_group_id
  source_security_group_id = local.worker_security_group_id
  from_port                = 443
  to_port                  = 443
  type                     = "ingress"
}