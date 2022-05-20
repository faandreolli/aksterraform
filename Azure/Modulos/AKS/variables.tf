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

variable "aksdnsprefix" {
  type        = string
  description = "Prefixo do DNS"
  default     = "" 
}