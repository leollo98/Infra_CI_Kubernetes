module "prod" {
    source = "../../infra"
    
    cluster_name = "homolog"
}

output "endereco" {
    value = module.prod.URL
}
