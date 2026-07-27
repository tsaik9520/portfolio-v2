# Personal Portfolio

Static portfolio site for Kevin Tsai, hosted on AWS via S3 and CloudFront, provisioned with Terraform.

**Live site:** https://d2e1wds6r4o5jd.cloudfront.net

## Structure

```
site/           Static site (HTML/CSS/JS) — the source of truth for content
  index.html
  css/style.css
  js/script.js
  404.html
infra/          Terraform config for the S3 + CloudFront hosting stack
  main.tf       S3 bucket (private), CloudFront distribution + Origin Access Control
  variables.tf
  outputs.tf
deploy.sh       Syncs site/ to S3 and invalidates the CloudFront cache
```

## Architecture

The site is served entirely through CloudFront. The S3 bucket blocks all public access — CloudFront
reads from it using Origin Access Control (OAC), and the bucket policy only allows requests from that
specific CloudFront distribution. There is no public S3 endpoint.

## Local preview

The site has no build step. Serve `site/` with any static file server, e.g.:

```bash
cd site && python3 -m http.server 8721
```

Then open `http://localhost:8721/index.html`.

## Deploying

Infrastructure and app deploy are separate steps.

1. **Provision infrastructure** (first time only, or after changing `infra/`):
   ```bash
   cd infra
   terraform init
   terraform apply
   ```
2. **Deploy site content**:
   ```bash
   ./deploy.sh
   ```
   This reads the bucket name and distribution ID from Terraform outputs, runs `aws s3 sync site/ s3://<bucket> --delete`,
   and invalidates the CloudFront cache. Requires valid AWS credentials and the Terraform state to be
   available locally (state is not checked into the repo — see `.gitignore`).
