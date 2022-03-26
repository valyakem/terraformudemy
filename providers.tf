
terraform {
  required_providers {
      aws = {
        source =  "hashicorp/aws"
      } 
      random = {
	source = "hashicorp/random"
      }
}

backend "remote" {
organization = "Next-Generation-Business-IT-Solutions"
 
  
    workspaces {
      name = "terraformudemy"
    }
  }
}

# random providerss
provider "random" {}

## provider us-east-1
provider "aws" {
  region = "us-east-1"
}