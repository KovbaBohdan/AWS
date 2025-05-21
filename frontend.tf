module "label_frontend" {
  source = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.25.0"
  context = module.label.context
  name    = "frontend"
}

module "frontend_s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.6.0"

  bucket = "frontend-kovba-dev"

  force_destroy = true
}

module "cdn" {
  source              = "terraform-aws-modules/cloudfront/aws"
  version             = "4.1.0"
  default_root_object = "index.html"
  # aliases = ["cdn.example.com"]

  comment             = module.label_frontend.id
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100"
  retain_on_delete    = false
  wait_for_deployment = false

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "My awesome CloudFront can access"
  }

  origin = {
    s3_one = {
      domain_name = module.frontend_s3.s3_bucket_bucket_regional_domain_name
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one"
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3_one"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }



#   # viewer_certificate = {
#   #   acm_certificate_arn = "arn:aws:acm:us-east-1:135367859851:certificate/1032b155-22da-4ae0-9f69-e206f825458b"
#   #   ssl_support_method  = "sni-only"
#   # }
}



# ###################################
# # IAM Policy Document
# ###################################
data "aws_iam_policy_document" "oai" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.frontend_s3.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [module.cdn.cloudfront_origin_access_identity_iam_arns[0]]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [module.frontend_s3.s3_bucket_arn]

    principals {
      type        = "AWS"
      identifiers = [module.cdn.cloudfront_origin_access_identity_iam_arns[0]]
    }
  }
}

# ###################################
# # S3 Bucket Policy
# ###################################
resource "aws_s3_bucket_policy" "read_gitbook" {
  bucket = module.frontend_s3.s3_bucket_id
  policy = data.aws_iam_policy_document.oai.json
}