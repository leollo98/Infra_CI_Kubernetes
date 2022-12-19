terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.47"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "us-west-2"
}

data "aws_eks_cluster" "default" {
  depends_on = [module.eks]
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "default" {
  depends_on = [module.eks]
  name = var.cluster_name
}

provider "kubernetes" {
  depends_on = [data.aws_eks_cluster.default]
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}
