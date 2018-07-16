terraform {
  backend "s3" {
    bucket = "packagebot"
    key    = "terraform/packagebot.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
  version = "~> 1.27"
}
