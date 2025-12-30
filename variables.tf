variable "log_producer_app_name" {
 type = string
 description = "The Heroku app name for the app producing logs."
}

variable "promtail_app_name" {
 type = string
}

variable "job_name" {
  type = string
  description = "This was generated in the Grafana-labs"  
}

variable "loki_host" {
  type = string
  description = "This was generated in the Grafana-labs"
}

variable "loki_tenant_id" {
  type = string
  description = "This was generated in the Grafana-labs"
}

variable "loki_token" {
  type = string
  description = "This was generated in the Grafana-labs"
}
