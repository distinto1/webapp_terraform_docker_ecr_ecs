# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "eligant-terraform-state-remote"
    key            = "eligant_rentzone-ecs/terraform.tfstate"
    region         = "us-east-1"
    profile        = "zestAPP_user"
    dynamodb_table = "my-terraform-state-lock"
  }
}