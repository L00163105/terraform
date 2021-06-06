variable "provider_source" {
  description = "The provider name"
  type = string
  default = "hashicorp/aws"
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "avail_zone" {
  description = "Availability Zone"
  type        = string
  default     = "eu-west-1a"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "LYIT_AppServerInstance"
}

variable "iam_cdc_lyit" {
  description = "Tag name for IAM"
  type        = string
  default     = "IAM_KMN_CDC_LYIT"
}

variable "iac_cdc_lyit" {
  description = "Tag name for infrastructure"
  type        = string
  default     = "IaC in Kay McNulty CDC LYIT"
}

variable "priv_cdc_lyit" {
  description = "Private subnet infrastructure"
  type        = string
  default     = "Priv_Sub in Kay McNulty CDC LYIT"
}

variable "pub_cdc_lyit" {
  description = "Public subnet infrastructure"
  type        = string
  default     = "Pub_Sub in Kay McNulty CDC LYIT"
}


variable "owner_name" {
  description = "Owner of the Infrastructure"
  type        = string
  default     = "Ruth Lennon"
}

variable "proj_name" {
  description = "The Project Name"
  type        = string
  default     = "phoenix"
}