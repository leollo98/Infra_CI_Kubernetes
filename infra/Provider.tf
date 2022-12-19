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
  name = var.cluster_name
  depends_on = [module.eks.kubernetes_config_map.aws_auth]
}

data "aws_eks_cluster_auth" "default" {
  name = var.cluster_name
  depends_on = [module.eks.kubernetes_config_map.aws_auth]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}
