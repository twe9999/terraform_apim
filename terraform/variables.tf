variable "location" {
  type    = string
  default = "Japan East"
  description = "Name of the Location"
}
variable "group" {
  type    = string
  default = "ixtw"
}


variable "ip_restriction_allow_service_tag" {
  type    = set(string)
  default = ["AzureCloud", "ApiManagement", "LogicApps","AppService"]
}
variable "ip_restriction_allow_ip" {
  type = map(string)
  default = {
    "IBM-Gateway" = "128.168.132.46/32"
    "Test-IP-Range" = "100.10.10.0/24"
  }
}

variable "ip_internal_web_access" {
  type    = list(string)
  default = ["100.0.0.0/16"]
}
variable "subscription_id" {
  type    = string
  default = "default"
}
variable "node_env" {
  type    = string
  default = "sit"
}
variable "env" {
  type    = string
  default = "ixtwkenneth"
}
