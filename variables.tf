variable "nuon_id" {
  type        = string
  description = "Nuon install identifier. Used to name all resources."
}

variable "project_id" {
  type        = string
  description = "GCP project ID."
}

variable "region" {
  type        = string
  description = "GCP region."
}

variable "gcp_credentials_base64" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Service account credentials JSON, base64-encoded. Leave empty to use application default credentials."
}

variable "network" {
  type        = string
  default     = ""
  description = "Name of an existing VPC network. Leave empty to create a new one."
}

variable "enable_nuon_dns" {
  type        = string
  default     = "false"
  description = "Set to \"true\" to create Cloud DNS zones (requires public_root_domain)."
}

variable "public_root_domain" {
  type        = string
  default     = ""
  description = "Public root domain for the DNS zone (e.g. install.example.com). Required when enable_nuon_dns is true."
}

variable "internal_root_domain" {
  type        = string
  default     = ""
  description = "Internal root domain for the private DNS zone. Optional."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Additional labels to apply to all resources."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Nuon resource tags, merged with labels."
}
