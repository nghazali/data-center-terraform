variable "region_name" {
  description = "Name of the AWS region."
  type        = string
}

variable "environment_name" {
  description = "Name of the environment."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9\\-]{1,24}$", var.environment_name))
    error_message = "Invalid environment name. Valid name is up to 25 characters starting with alphabet and followed by alphanumerics. '-' is allowed as well."
  }
}

variable "vpc" {
  description = "vpc module that hosts the product."
  type        = any
}

variable "eks" {
  description = "EKS module that hosts the product."
  type        = any
}

variable "efs" {
  description = "EFS module to provide shared-home to the product."
  type        = any
}

variable "ingress" {
  default = null
  type    = any
}

variable "share_home_size" {
  description = "Shared home persistent volume size."
  type        = string
}

variable "license" {
  description = "Bamboo license."
  type        = string
  sensitive   = true
}

variable "bamboo_admin_info" {
  description = "Admin information for the Bamboo software"
  type        = map(any)
  validation {
    condition = (length(var.bamboo_configuration) == 4 &&
    alltrue([for o in keys(var.bamboo_configuration) : contains(["username", "password", "display_name", "email_address"], o)]))
    error_message = "Bamboo admin information is not valid."
  }
}

variable "bamboo_database_info" {
  description = "Database information for the Bamboo software"
  type        = map(any)
  validation {
    condition = (length(var.bamboo_configuration) == 3 &&
    alltrue([for o in keys(var.bamboo_configuration) : contains(["allocated_storage", "instance_class", "iops"], o)]))
    error_message = "Bamboo database information is not valid."
  }
}

variable "bamboo_configuration" {
  description = "Bamboo resource spec and chart version"
  type        = map(any)
  validation {
    condition = (length(var.bamboo_configuration) == 5 &&
    alltrue([for o in keys(var.bamboo_configuration) : contains(["helm_version", "cpu", "mem", "min_heap", "max_heap"], o)]))
    error_message = "Bamboo configuration is not valid."
  }
}

variable "bamboo_agent_configuration" {
  description = "Bamboo agent resource spec and chart version"
  type        = map(any)
  validation {
    condition = (length(var.bamboo_agent_configuration) == 4 &&
    alltrue([for o in keys(var.bamboo_agent_configuration) : contains(["helm_version", "cpu", "mem", "agent_count"], o)]))
    error_message = "Bamboo Agent configuration is not valid."
  }
}

variable "bamboo_database_type" {
  description = "Type of the database for Bamboo"
  type = string
  default = "postgresql"
}

variable "dataset_url" {
  description = "URL of the dataset to restore in the Bamboo instance"
  type        = string
}

variable "bamboo_internal_use" {
  description = "This variable is reserved for internal use"
  type = string
}
