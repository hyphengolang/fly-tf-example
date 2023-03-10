variable "cluster_name" {
  type     = string
  nullable = false
}

variable "serverless_spend_limit" {
  type     = number
  nullable = false
  default  = 0
}

variable "cloud_provider" {
  type     = string
  nullable = false
  default  = "AWS"
}

variable "cloud_provider_regions" {
  type     = list(string)
  nullable = false
  default  = ["eu-west-1"]
}

data "cockroach_connection_string" "cockroach" {
  id       = cockroach_cluster.cluster.id
  sql_user = cockroach_sql_user.cluster.name
  password = cockroach_sql_user.cluster.password
}
