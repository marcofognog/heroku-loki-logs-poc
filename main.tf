terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 5.3"
    }
  }
}

resource "heroku_app" "log_producer" {
  stack="container"
  name   = var.log_producer_app_name
  region = "us"
}

resource "heroku_build" "log_producer_build" {
  app_id = heroku_app.log_producer.id

  source {
    path = "log-producer"
  }
}

resource "heroku_app" "promtail" {
  stack="container"
  name   = var.promtail_app_name
  region = "us"

  config_vars = {
    JOB_NAME = var.job_name
    LOKI_HOST = var.loki_host
    LOKI_TENANT_ID = var.loki_tenant_id
    LOKI_TOKEN = var.loki_token
  }
}

resource "heroku_build" "promtail-build" {
  app_id = heroku_app.promtail.id

  source {
    path = "promtail"
  }
}

resource "heroku_drain" "log_producer_drain" {
  app_id = heroku_app.log_producer.id
  url = "${heroku_app.promtail.web_url}/heroku/api/v1/drain"
}

resource "heroku_formation" "log_producer_formation" {
  app_id = heroku_app.log_producer.id
  type = "worker"
  size = "basic"
  # or size = "standard-1x"

  quantity = 1
  # quantity = 10
  # quantity = 50 # !!!
}

resource "heroku_formation" "promtail_formation" {
  app_id = heroku_app.promtail.id
  type = "web"
  quantity = 1
  size = "basic"
}