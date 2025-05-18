output "cloudfront_domain_name" {
  description = "CloudFront Distribution Domain Name (for diagnostics)"
  value       = aws_cloudfront_distribution.superset_distribution.domain_name
}

output "custom_domain_url" {
  description = "Access Superset via custom domain (HTTPS)"
  value       = "https://${var.domain_name}"
}
