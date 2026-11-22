variable "subscription_id" {
  type    = string
  default = "8999b3c0-35d0-4d50-870d-048f32c71e67"
}

variable "resource_group_name" {
  type    = string
  default = "rg-mikhail.kazachonak"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "admin_ssh_public_key" {
  type = string
}

variable "admin_cidr" {
  type = string

  validation {
    condition     = can(cidrhost(var.admin_cidr, 0))
    error_message = "admin_cidr должен быть CIDR, например 203.0.113.10/32."
  }
}

variable "web_vm_size" {
  type    = string
  default = "Standard_F1als_v7"
}

variable "monitoring_vm_size" {
  type    = string
  default = "Standard_F1als_v7"
}
