resource "aws_s3_bucket" "this" {
  bucket = format("%s-%s-s3", var.project, var.environment)
}

resource "aws_s3_object" "this" {
  bucket = aws_s3_bucket.this.bucket
  key    = "kubernetes.yaml"
  content = local.manifests_content
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.allow_read_only_access.json
}

data "aws_iam_policy_document" "allow_read_only_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::211125381571:role/LabRole"]
    }
    
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
  
    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*",
    ]
  }
}

resource "aws_efs_file_system" "this" {
  tags = {
    Environment = var.environment
  }
}