variable "tenant_id" {
  type = string
  description = "Tenant do ambiente" 
  
}

variable "resoucegroup" {
  type = string
  description = "Resource Group do AKS"
  default = ""
}

variable "environment" {
  type        = string
  description = "ambiente que será criado"
  default     = ""
}

variable "location" {
  type        = string
  description = "Região da Azure onde será criado o ambiente"
  default     = ""
}

variable "aksname" {
  type        = string
  description = "Nome do AKS"
  default     = ""
}

variable "tag_environment" {
  type        = string
  description = "tag do ambiente que será criado"
  default     = ""
}

variable "tag_createBy" {
  type = string
  description = "por onde esta sendo criado"
  default = "Terraform"
  
}