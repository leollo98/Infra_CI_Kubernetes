module "prod" {
  source = "../../infra"

  cluster_name = "homolog"
}

output "IP_db" {
  value = module.prod.IP
}
