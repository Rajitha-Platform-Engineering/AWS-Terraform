resource "kubernetes_secret" "main" {
  metadata {
    name      = "slack-webhook"
    namespace = "prometheus"
  }

  data = {
    slack_webhook_url = "https://hooks.slack.com/services/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"
  }

  type = "Opaque"
}