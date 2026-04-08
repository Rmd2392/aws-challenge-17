#####################################
# EKS en AWS Academy Learner Lab
# - NO se puede crear roles IAM (iam:CreateRole da 403)
# - Se usa el rol existente "LabRole"
#####################################

# Referenciamos el rol ya creado por el Learner Lab
data "aws_iam_role" "labrole" {
  name = "LabRole"
}

#####################################
# Cluster EKS
#####################################
resource "aws_eks_cluster" "this" {
  name = local.cluster_name

  # Rol del control plane (usamos LabRole)
  role_arn = data.aws_iam_role.labrole.arn

  # Versión de Kubernetes (deja la que te pida el reto/curso)
  version = "1.34"

  vpc_config {
    # Subredes privadas para el cluster
    subnet_ids              = module.vpc.private_subnets
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = local.tags
}

#####################################
# Node Group gestionado
#####################################
resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${local.name}-ng"

  # Rol de los nodos (usamos LabRole)
  node_role_arn = data.aws_iam_role.labrole.arn

  # Subredes privadas para los nodos
  subnet_ids = module.vpc.private_subnets

  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"

  launch_template {
    id      = aws_launch_template.repte17_ng.id
    version = "$Latest"
  }

  scaling_config {
    min_size     = 1
    desired_size = 1
    max_size     = 2
  }

  tags = local.tags
}
