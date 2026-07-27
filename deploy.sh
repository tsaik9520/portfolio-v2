#!/usr/bin/env bash
# Syncs site/ to the S3 bucket managed by Terraform and invalidates the CloudFront cache.
# Run `terraform apply` in infra/ first so the bucket and distribution exist.
set -euo pipefail

cd "$(dirname "$0")"

BUCKET=$(terraform -chdir=infra output -raw s3_bucket_name)
DISTRIBUTION_ID=$(terraform -chdir=infra output -raw cloudfront_distribution_id)
SITE_URL=$(terraform -chdir=infra output -raw site_url)

echo "Syncing site/ to s3://${BUCKET} ..."
aws s3 sync site/ "s3://${BUCKET}" --delete

echo "Invalidating CloudFront cache (${DISTRIBUTION_ID}) ..."
aws cloudfront create-invalidation --distribution-id "${DISTRIBUTION_ID}" --paths "/*" >/dev/null

echo "Deployed: ${SITE_URL}"
