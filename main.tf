#create S3 bucket : 

resource "aws_s3_bucket" "ProjectBuck" {

  bucket = var.bucketname

}


# to automate - making the user ownership, refine woenership so taht ervrything shud be owned by us 
# and thence no one can make bad usage of this, 
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.ProjectBuck.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


# to automate - make=ing the bucket public
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.ProjectBuck.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}


# this is to grant reading for public via - ACL 
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.ProjectBuck.id
  acl    = "public-read"
}


# to make the static hosting enabled, we shud use website-configure
# but even befoe that we need an index.html and even shud have already configured the 
# the error.html along with index prior to automating the process of making the S3 be Static Hosting enabled


# so now go uplaod the resources (html, js , css, img)
resource "aws_s3_object" "index" {
  bucket = var.bucketname
  key    = "index.html"
  source = "index.html"
#   this also is imp one, to make it publicly readable
  acl = "public-read"
  content_type = "text/html"

  etag = filemd5("index.html")

    depends_on = [aws_s3_bucket.ProjectBuck]

}


resource "aws_s3_object" "error" {
  bucket = var.bucketname
  key    = "error.html"
  source = "error.html"
#   this also is imp one, to make it publicly readable
  acl = "public-read"
  content_type = "text/html"

  etag = filemd5("error.html")
}


resource "aws_s3_object" "script" {
  bucket = var.bucketname
  key    = "script.js"
  source = "script.js"
#   this also is imp one, to make it publicly readable
  acl = "public-read"
  content_type = "application/javascript"

  etag = filemd5("script.js")
}


# so now go uplaod the resources (html, js , css, img)
resource "aws_s3_object" "styloo" {
  bucket = var.bucketname
  key    = "styles.css"
  source = "styles.css"
#   this also is imp one, to make it publicly readable
  acl = "public-read"
  content_type = "text/css"

  etag = filemd5("styles.css")
}


resource "aws_s3_object" "img" {
  bucket = var.bucketname
  key    = "bhaski.jpg"
  source = "bhaski.jpg"
#   this also is imp one, to make it publicly readable
  acl = "public-read"

  etag = filemd5("bhaski.jpg")
}


# now lets configue wthe site for our index.html and error.html as well

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.ProjectBuck.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  } 

  depends_on = [ aws_s3_bucket.ProjectBuck ]
}