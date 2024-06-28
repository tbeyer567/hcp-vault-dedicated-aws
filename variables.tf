variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "hvn_cidr" {
  description = "CIDR range for HVN, cannot overlap with cloud CIDR ranges, must be between a /16 and /25."
  type        = string
  default     = "172.16.1.0/20"
}

variable "cluster_id" {
  description = "The ID of the HCP Vault cluster."
  type        = string
  default     = "vault-cluster"
}

variable "cluster_tier" {
  description = "Tier of the HCP Vault cluster."
  type        = string
  default     = "standard_small"
}

variable "vpc_id" {
  description = "VPC ID for peering setup."
  type        = string
}

variable "peering" {
  description = "When true enable VPC Peering, when false enable Transit Gateway Attachment."
  type        = bool
  default     = true
}