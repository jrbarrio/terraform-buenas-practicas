terraform {

# Backend elements (S3 bucket and DynamoDB table) have been created from the AWS console
# This infrastructure resources could be imported and managed in a different terraform project

  backend "s3" {
    bucket = "jorgerb-codely-tfstates"
    key = "apps/terraform.tfstate"
    encrypt = true
    dynamodb_table = "jorgerb-codely-tfstates"

    region = "eu-west-1"
    # skip_region_validation = true
  }
}