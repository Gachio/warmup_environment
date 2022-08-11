    provider "aws" {
            region = "us-east-2"
    }


    resource "aws_instance" "warmspace" {
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = terraform.workspace == "default" ? "t2.medium" : "t2.micro"
    }

    terraform {
        backend "s3" {
            bucket = "warmup-running-state"
            key = "workspaces-warmspace/terraform.tfstate"
            region = "us-east-2"
            dynamodb_table = "warmup-running-locks"
            encrypt = true
        }
    }
