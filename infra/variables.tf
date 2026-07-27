variable "project_name" {
  description = "Name used to prefix and tag resources"
  type        = string
  default     = "personal-portfolio"
}

variable "aws_region" {
  description = "AWS region to deploy the S3 bucket in"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment tag"
  type        = string
  default     = "production"
}

variable "cloudfront_price_class" {
  description = "CloudFront price class (controls edge locations used)"
  type        = string
  default     = "PriceClass_100"
}
