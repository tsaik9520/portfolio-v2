output "s3_bucket_name" {
  description = "Name of the S3 bucket holding the site files"
  value       = aws_s3_bucket.site.id
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID (needed for cache invalidation)"
  value       = aws_cloudfront_distribution.site.id
}

output "cloudfront_domain_name" {
  description = "CloudFront domain name to visit the site"
  value       = aws_cloudfront_distribution.site.domain_name
}

output "site_url" {
  description = "HTTPS URL of the deployed site"
  value       = "https://${aws_cloudfront_distribution.site.domain_name}"
}
