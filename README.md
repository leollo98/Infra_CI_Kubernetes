
# Resumo do projeto

  

Primeiro projeto de Infraestrutura como código com Kubernetes, utilizando Terraform para provisionamento e AWS como provedor da infraestrutura.

  

## 🔨 Funcionalidades do projeto

  

A partir desse projeto você pode:

  

- Criar ambientes para aplicações no Kubernetes

- Separar o seu código em múltiplos ambientes, dependendo das necessidades

- Criar módulos para acelerar o desenvolvimento no Terraform

  

## ✔️ Técnicas e tecnologias utilizadas

  

Neste App são exploradas as seguintes técnicas e tecnologias:

  

-  **Criação de maquinas para executar PODs do Kubernetes**: criação de maquinas de forma automática pelo EkS (Elastic Kubernetes Service) da AWS feito de forma automática.

-  **Utilização de módulos**: Utilização dos módulos do Terraform, desenvolvidos pelos provedores e comunidade

-  **Elastic Constainer Registry**: o repositório de containers da AWS, onde vamos colocar as nossas imagens.


  

## 📁 Acesso ao projeto

  

Você pode [baixar o zip](https://github.com/leollo98/iac-curso6/archive/refs/heads/Aula_5.zip) ou [acessar o código fonte](https://github.com/leollo98/iac-curso6/tree/Aula_5) do projeto final.

  

## 🛠️ Abrir e rodar o projeto

  

O projeto foi desenvolvido no VSC (Visual Studio Code), sendo assim, instale o VSC (pode ser uma versão mais recente) e, na tela inicial, procure a opção extensões, ou aperte Ctrl+Shift+X, e busque por HashiCorp Terraform, assim teremos o suporte do intellisense, tornando o trabalho de escrever o código mais rápido.

  

> Caso baixou o zip, extraia o projeto antes de procurá-lo, pois não é possível abrir via arquivo zip

  

Vá até a paste a abra a pasta do projeto. Após abrir o projeto abra um terminal, pode ser o integrado com o VSC, navegue até a pasta `env/Prod`  e execute o comando `terraform init` dentro dela, agora temos o Terraform iniciado e podemos começar a utilizá-lo. Para criar a infraestrutura, execute o `terraform apply` na pastas de Produção (`env/Prod`).

  

🏆