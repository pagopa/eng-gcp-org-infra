variable "organization_id" {
  description = "ID della org GCP"
  type        = string
  default     = "520838205140"
}

variable "customer_id" {
  description = "CustomerID Google Cloud"
  type        = string
  default     = "C00siwdxu"
}

variable "domain" {
  description = "Dominio Google Workspace (ad esempio, mycompany.com)"
  type        = string
  default     = "pagopa.it"
}

variable "project_id" {
  description = "ID del progetto GCP"
  type        = string
  default     = "organization-443016"
}

variable "region" {
  description = "Regione GCP"
  type        = string
  default     = "europe-west8"
}

variable "zone" {
  description = "Zona GCP"
  type        = string
  default     = "europe-west8-a"
}

variable "topic_name" {
  type        = string
  default     = "sentinel-topic"
  description = "Name of sentinel topic"
}

variable "tenant_id" {
  type        = string
  nullable    = false
  description = "Please enter your Sentinel tenant id"
  default     = "7788edaf-0346-4068-9d79-c868aed15b3d"
}

variable "workload_identity_pool_id_exists" {
  type        = string
  nullable    = false
  description = "A workload Identity Pool has already been created for Azure? (yes/no)"
}
