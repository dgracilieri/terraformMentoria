resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  depends_on            = [aws_s3_bucket.c2bucket, aws_s3_bucket.c2bucketlog]
  comment = var.s3_origin_id
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  depends_on            = [aws_s3_bucket.c2bucket, aws_s3_bucket.c2bucketlog, aws_wafv2_web_acl.waf_sql_inject]
  origin {
    domain_name = aws_s3_bucket.c2bucket.bucket_regional_domain_name
    origin_id   = var.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "my-cloudfront_carancas"
  default_root_object = "index.html"

  # Configure logging here if required 	
  logging_config {
    include_cookies = true
    bucket          = aws_s3_bucket.c2bucketlog.bucket_regional_domain_name
    prefix          = "Cloudops"
  }

  # If you have domain configured use it here 
  #aliases = ["mywebsite.example.com", "s3-static-web-dev.example.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = var.s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CO"]
    }
  }

  tags = merge({Name = join("-",tolist(["CloudFront", var.marca, var.environment]))},local.tags)
  web_acl_id = aws_wafv2_web_acl.waf_sql_inject.arn

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
