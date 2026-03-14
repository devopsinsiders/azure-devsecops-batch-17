variable "resource_group_name" {
  default = "bhakua-rg"
}

variable "location" {
  default = "Central India"
}

variable "vnet_name" {
  default = "bhakua-spoke-vnet"
}

variable "vnet_address_space" {
  default = ["10.24.0.0/16"]
}

variable "subnet_name" {
  default = "bhakua-subnet"
}

variable "subnet_prefix" {
  default = ["10.24.1.0/24"]
}

variable "vm_name" {
  default = "bhakua-frontend-vm"
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "admin_username" {
  default = "azureuser"
}

variable "admin_password" {
  default = "P@ssw01rd@123"
}

variable "storage_account_name" {
  default = "bhakuavdostg"
}