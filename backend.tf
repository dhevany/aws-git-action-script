terraform {
  backend "s3" {
    bucket       = "dhevan-devops-terraform-state"
    key          = "two-tier-app/terraform.tfstate"
    region       = "ca-central-1"
    encrypt      = true
   }
}
