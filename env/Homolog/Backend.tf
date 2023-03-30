terraform {
  backend "s3" {
    bucket = "terraform-state-gitaction-eks"
    key    = "Prod/terraform.tfstate"
    region = "us-east-1"
  }
}
