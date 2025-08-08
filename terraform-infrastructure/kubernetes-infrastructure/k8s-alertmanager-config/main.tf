resource "kubernetes_manifest" "alertmanager_config" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1alpha1"
    kind       = "AlertmanagerConfig"
    metadata = {
      name      = "alertmanager-config"
      namespace = "prometheus"
      labels = {
        release = "prometheus"
      }
    }
    spec = {
      route = {
        groupBy        = ["alertname"]
        receiver       = "slack-notifications"
        groupWait      = "30s"
        groupInterval  = "5m"
        repeatInterval = "3h"
        routes = [{
          receiver = "slack-notifications"
          continue = true
        }]
      }
      receivers = [{
        name = "slack-notifications"
        slackConfigs = [{
          channel = "#devops-alerts-new"
          apiURL = {
            name = "slack-webhook"     # Reference to the Kubernetes Secret
            key  = "slack_webhook_url" # The specific key inside the secret
          }
          title = "🚨 Alert: {{ .CommonAnnotations.summary }}"
          text  = "{{ .CommonAnnotations.description }}"
        }]
      }]
    }
  }
}
