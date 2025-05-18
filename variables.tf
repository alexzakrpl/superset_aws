variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "EC2 Key Pair name for SSH access"
  type        = string
  default = "superset-key"
}

variable "superset_env" {
  description = "Map of environment variables for Superset .env file"
  type        = map(string)
}

variable "hosted_zone_id" {
  description = "Route 53 Hosted Zone ID"
  type        = string
  default = "Z04527133T6OE16LJ1T4X"
}

variable "domain_name" {
  description = "Domain name for Superset"
  type        = string
  default     = "superset.zakrzewski.me"
  }

