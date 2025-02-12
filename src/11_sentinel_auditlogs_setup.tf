resource "google_project_service" "enable-logging-api" {
  service            = "logging.googleapis.com"
  project            = data.google_project.project.project_id
  disable_on_destroy = false
}

resource "google_pubsub_topic" "sentinel-topic" {
  count   = var.topic_name != "sentinel-topic" ? 0 : 1
  name    = var.topic_name
  project = data.google_project.project.project_id
}

resource "google_pubsub_subscription" "sentinel-subscription" {
  project    = data.google_project.project.project_id
  name       = "sentinel-subscription-auditlogs"
  topic      = var.topic_name
  depends_on = [google_pubsub_topic.sentinel-topic]
}

resource "google_logging_organization_sink" "sentinel-organization-sink" {
  count            = var.organization_id == "" ? 0 : 1
  name             = "audit-logs-organization-sentinel-sink"
  org_id           = var.organization_id
  destination      = "pubsub.googleapis.com/projects/${data.google_project.project.project_id}/topics/${var.topic_name}"
  include_children = true
}

resource "google_project_iam_binding" "log-writer-sentinel-organization-sink" {
  count   = var.organization_id == "" ? 0 : 1
  project = data.google_project.project.project_id
  role    = "roles/pubsub.publisher"

  members = [
    google_logging_organization_sink.sentinel-organization-sink[0].writer_identity
  ]
}

# send pagopa.it organization log to google project log
resource "google_logging_organization_sink" "sentinel-organization-project-sink" {
  count            = var.organization_id == "" ? 0 : 1
  name             = "audit-logs-organization-project-sink"
  org_id           = var.organization_id
  destination      = "logging.googleapis.com/projects/${data.google_project.project.project_id}"
  include_children = true
}

resource "google_project_iam_binding" "log-writer-organization-project-sink" {
  count   = var.organization_id == "" ? 0 : 1
  project = data.google_project.project.project_id
  role    = "roles/logging.logWriter"

  members = [
    google_logging_organization_sink.sentinel-organization-project-sink[0].writer_identity
  ]
}
