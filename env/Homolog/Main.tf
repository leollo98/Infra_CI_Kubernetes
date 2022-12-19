module "prod" {
    source = "../../infra"

    nome_repositorio = "producao"
    cluster_name = "homolog"
}

output "endereco" {
    value = module.prod.URL
}
