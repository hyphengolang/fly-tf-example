terraform {
  required_providers {
    cockroach = {
      source  = "cockroachdb/cockroach"
      version = ">= 0.4.0"
    }
  }
}

resource "cockroach_cluster" "cluster" {
  name           = var.cluster_name
  cloud_provider = var.cloud_provider
  serverless = {
    spend_limit = var.serverless_spend_limit
  }
  regions = [for r in var.cloud_provider_regions : { name = r }]
}

resource "cockroach_sql_user" "cluster" {
  name       = "postgres"
  cluster_id = cockroach_cluster.cluster.id
}
