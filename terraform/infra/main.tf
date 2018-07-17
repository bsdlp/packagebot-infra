variable "aws_region" {}
variable "aws_account_id" {}
variable "environment" {}

provider "aws" {
  region                  = "${var.aws_region}"
  allowed_account_ids     = ["${var.aws_account_id}"]
  skip_metadata_api_check = true
}

/*
module "item_images" {
  source      = "./item_images"
  environment = "${var.environment}"
}
*/

