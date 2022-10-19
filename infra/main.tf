terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "~> 4.26.0"
    }
  }

  required_version = ">= 0.14.3"
}

provider "aws" {
  region = "eu-west-2"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../bin/lambda"
  output_path = "../bin/lambda.zip"
}



