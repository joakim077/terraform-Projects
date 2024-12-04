variable "vpc_config" {
    description = "value of name and CIDR of VPC"
    type = object({
        cidr = string
        name = string
    })
      # Validate the CIDR block of VPC
    validation {
      condition = can(cidrnetmask(var.vpc_config.cidr))
      error_message = "Invalid CIDR format - ${var.vpc_config.cidr}"
    }
}

variable "subnet_config" {
    description = "enter CIDR and AZ of VPC"
    type = map(object({
       cidr = string
       az = string 
       public = optional(bool, false)
    }))
    # Validate the CIDR block of subnets
    validation {
      condition = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr))])
      error_message = "Invalid CIDR for subnet"
    }
}