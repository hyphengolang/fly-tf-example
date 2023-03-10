variable "orginization" {
  type        = string
  description = "value of org in fly_app"
  default     = "personal"
}

variable "regions" {
  type        = list(string)
  description = "value of regions in fly_machine: https://fly.io/docs/reference/regions/"
  default     = ["lhr"]
}

variable "name" {
  type        = string
  description = "value of name in fly_app"
  nullable    = false
}

variable "internal_port" {
  type        = number
  description = "value of internal_port in services"
  default     = 8080
}

variable "image" {
  type        = string
  description = "value of image in fly_machine"
  nullable    = false
}

variable "env" {
  type        = map(string)
  description = "value of env in fly_machine"
  default     = {}
}
