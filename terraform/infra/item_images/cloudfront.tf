locals {
  item_images_origin_id = "item_images_origin"
}

resource "aws_cloudfront_origin_access_identity" "item_images" {
  comment = "item images"
}

resource "aws_cloudfront_distribution" "item_images" {
  enabled         = true
  is_ipv6_enabled = true

  origin {
    domain_name = "${aws_s3_bucket.item_images.bucket_regional_domain_name}"
    origin_id   = "${local.item_images_origin_id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.item_images.cloudfront_access_identity_path}"
    }
  }

  default_cache_behavior {
    allowed_methods  = ["HEAD", "GET", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${local.item_images_origin_id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "https-only"
    min_ttl                = 3600
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_100"
}
