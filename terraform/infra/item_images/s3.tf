resource "aws_s3_bucket" "item_images" {
  bucket = "${var.environment}.items.images.packagebot"
  acl    = "private"
}

data "aws_iam_policy_document" "item_images_s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.item_images.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.item_images.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.item_images.arn}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.item_images.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket_policy" "item_images_cf" {
  bucket = "${aws_s3_bucket.item_images.id}"
  policy = "${data.aws_iam_policy_document.item_images_s3_policy.json}"
}
