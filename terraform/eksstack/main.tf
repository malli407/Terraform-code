# module "eksiam" {
#    source = "../modules/common/iam"
#    manage_cluster_iam_resources = true
#    cluster_iam_role_name = "${var.env}-eksrole"
   
# }
module "iam" {
  source = "../modules/iam"

  service_role_name = "eksServiceRole-${var.cluster_name}"
  node_role_name    = "EKSNode-${var.cluster_name}"
}

module "cluster" {
  depends_on = [module.iam]
  source = "../modules/cluster"

  name = var.cluster_name

  vpc_config = var.vpc_config
  iam_config = module.iam.config

  aws_auth_role_map = var.aws_auth_role_map
  aws_auth_user_map = var.aws_auth_user_map

  envelope_encryption_enabled = var.envelope_encryption_enabled
}

module "node_group" {
  source = "../modules/asg_node_group"

  cluster_config = module.cluster.config
}