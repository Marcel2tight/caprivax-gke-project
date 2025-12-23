variable "project_id" {
  type = string
}

variable "env" {
  type        = string
  description = "The environment (e.g., dev, staging, prod)"
  default     = "dev"
}

variable "company_name" {
  type    = string
  default = "caprivax"
}

variable "region" {
  type    = string
  default = "us-central1"
}