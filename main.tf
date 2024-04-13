terraform {
  required_providers {
    aws = {
      version = "~>5.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

module "alb-asg-security-group" {
  source = "./modules/sg"
  providers = {
    aws = aws
  }
}
