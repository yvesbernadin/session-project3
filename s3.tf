resource "aws_s3_bucket" "aws-project3" {
  bucket = "bucket-project3-tf"

  tags = {
    Name        = "aws-Project3"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning_aws-project3" {
  bucket = aws_s3_bucket.aws-project3.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Public access block configuration


resource "aws_s3_bucket_ownership_controls" "ownership-project3" {
  bucket = aws_s3_bucket.aws-project3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "access_block-project3" {
  bucket = aws_s3_bucket.aws-project3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "acl-project3" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership-project3,
    aws_s3_bucket_public_access_block.access_block-project3,
  ]

  bucket = aws_s3_bucket.aws-project3.id
  acl    = "public-read"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aws_encript-project3" {
  bucket = aws_s3_bucket.aws-project3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_object" "object-project3" {
  for_each = fileset("lambda-tutorial-app-main/", "**")
  bucket = aws_s3_bucket.aws-project3.id
  key = each.value
  source = "lambda-tutorial-app-main/${each.value}"
  etag = filemd5("lambda-tutorial-app-main/${each.value}")
}

resource "aws_s3_bucket_policy" "allow_access_to-S3" {
  bucket = aws_s3_bucket.aws-project3.id   
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",             
            "Resource": "arn:aws:s3:::bucket-project3-tf/*"
        }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "website-project3" {
  bucket = aws_s3_bucket.aws-project3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
 
}