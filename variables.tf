variable "nuon_id" {
  type        = string
  description = "The nuon id for this install."
}

variable "project_id" {
  type        = string
  description = "The GCP project ID."
}

variable "region" {
  type        = string
  description = "The GCP region."
}

variable "enable_nuon_dns" {
  type        = string
  default     = "false"
  description = "Whether to create Cloud DNS zones for the install."
}

variable "public_root_domain" {
  type        = string
  default     = ""
  description = "The public root domain."
}

variable "internal_root_domain" {
  type        = string
  default     = ""
  description = "The internal root domain."
}

variable "gcp_credentials_base64" {
  type        = string
  sensitive   = true
  default     = ""
  description = "GCP service account credentials JSON, base64 encoded."
}

variable "network" {
  type        = string
  default     = ""
  description = "Name of an existing VPC network. If empty, a new VPC is created."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels to apply to all resources."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Tags to add to install resources."
}

variable "additional_tags" {
  type        = map(any)
  default     = {}
  description = "Extra tags to append to the default tags."
}
