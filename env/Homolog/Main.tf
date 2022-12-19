module "prod" {
    source = "../../k8s"
    
    cluster_name = "homolog"
}

output "endereco" {
    value = module.prod.URL
}
