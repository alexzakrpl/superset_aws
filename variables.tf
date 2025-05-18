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
