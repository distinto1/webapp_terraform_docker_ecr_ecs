# store the terraform state file in s3 and lock with dynamodb. Config set in backend.hcl file
terraform {
  backend "s3" {
    
  }
}
