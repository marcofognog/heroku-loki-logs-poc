## Heroku logs with Loki - Proof of Concept

### Purpose

Centralize the logs from Heroku app dynos into Loki hosted on GrafanaLabs, to be visialized on GrafanaCloud.

* "log-producer" is a sample app that plays the role of a "normal" app that produces logs, amongst other this. In this case, it only produces logs, because that's all we need.

* Promtail is an instance of [Promtail](https://grafana.com/docs/loki/latest/send-data/promtail/)
that "collects" the logs from Heroku and sends to Loki.

The Terraform scripts create and configure both apps on Heroku. Loki and Grafana are hosted on GrafanaLabs (as a Saas service).

### Setup instructions

Follow the steps to create your token describe [here](https://grafana.com/blog/how-to-easily-configure-grafana-loki-and-promtail-to-receive-logs-from-heroku/#:~:text=Click%20the%20Details%20button%20under%20the%20Loki%20card).

When the forementioned text starts talking about creating apps on Heroku, you skip all of that and do this instead:

Rename `prod.tfvars.example` to `prod.tfvars`, replace the variables with your credentials and run the usual Terraform cycle (you know, `plan`, `apply`, etc ...), like


```
$ terraform apply -var-file=prod.tfvars
```

If you are skeptical person, log in to Heroku and check your apps, or better yet, use the `heroku` CLI.

Then you can come back to the [article to build your charts in Grafana](https://grafana.com/blog/how-to-easily-configure-grafana-loki-and-promtail-to-receive-logs-from-heroku/#:~:text=Test%20everything).

### Links for rerence

* https://devcenter.heroku.com/articles/log-drains#https-drains
* https://registry.terraform.io/providers/heroku/heroku/latest/docs/resources/app