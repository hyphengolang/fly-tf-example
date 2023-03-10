variable "address" {
  type        = string
  description = "value of the address"
  default     = "registry-1.docker.io"
}

variable "context" {
  type        = string
  description = "value of the context"
  default     = ""
}

variable "registry" {
  type        = string
  description = "value of the registry"
  default     = "adoublef"
}

variable "repository" {
  type        = string
  description = "value of the repository"
  nullable    = false
}

variable "tag" {
  type        = list(string)
  description = "value of the tag"
  default     = ["latest"]
}
