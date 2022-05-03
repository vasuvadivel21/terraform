provider "aws" { 
  region = "us-east-1"
}
#source bucket
resource "aws_s3_bucket" "source" {
 
  bucket   = "s3-source-sync-testing-vasu"
  acl = "private"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "S3_bucket_sync_Access",
            "Effect": "Allow",
            "Principal": {"AWS": "237092322265"},
            "Action": ["s3:ListBucket","s3:GetObject"],
            "Resource": [
                "arn:aws:s3:::s3-source-sync-testing-vasu/*",
                "arn:aws:s3:::s3-source-sync-testing-vasu"
            ]
        }
    ]
}
POLICY
}
  

  resource "aws_s3_bucket_acl" "source_bucket_acl" {
         bucket = aws_s3_bucket.source.id
         acl    = "private"
 
}
#source bucket versioning
resource "aws_s3_bucket_versioning" "source" {
 

  bucket = aws_s3_bucket.source.id
  versioning_configuration {
    status = "Enabled"
  }
}

#Destination bucket policy
resource "aws_s3_bucket" "destination" {
  provider = aws.east
  bucket = "s3-destination-sync-testing-vasu"
  acl = "private" 
   
   policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {

            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::237092322265:root"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::s3-destination-sync-testing-vasu/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::237092322265:root"
            },
            "Action":"s3:*",
            "Resource": "arn:aws:s3:::s3-destination-sync-testing-vasu"
        }
        
    ]
    
}
POLICY
}
#Destination bucket versioning
resource "aws_s3_bucket_versioning" "destination" {
  provider = aws.east
  bucket = aws_s3_bucket.destination.id
  versioning_configuration {
    status = "Enabled"
  }
  
}

#Destination bucket storage type
# destination {
#       bucket        = aws_s3_bucket.destination.arn
#       storage_class = "STANDARD"
#     }

resource "aws_instance" "ec2" {
  provider = aws.east
  ami = "ami-0f9fc25dd2506cf6d"
  key_name = "my-key"
  instance_type = "t2.micro"
}
resource "aws_iam_user" "iam" {
   provider = aws.east
   name = "vasu"
   path = "/"

   tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "iam-key" {
  user = aws_iam_user.iam.name

  
}
