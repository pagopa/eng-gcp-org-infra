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

resource "google_logging_project_sink" "sentinel-sink" {
  project                = data.google_project.project.project_id
  count                  = var.organization_id != "" ? 1 : 0
  name                   = "audit-logs-sentinel-sink"
  destination            = "pubsub.googleapis.com/projects/${data.google_project.project.project_id}/topics/${var.topic_name}"
  depends_on             = [google_pubsub_topic.sentinel-topic]
  unique_writer_identity = true
}

# resource "google_logging_organization_sink" "sentinel-organization-sink" {
#   count            = var.organization_id == "" ? 0 : 1
#   name             = "audit-logs-organization-sentinel-sink"
#   org_id           = var.organization_id
#   destination      = "pubsub.googleapis.com/projects/${data.google_project.project.project_id}/topics/${var.topic_name}"
#   include_children = true
# }

resource "google_project_iam_binding" "log-writer" {
  count   = var.organization_id != "" ? 1 : 0
  project = data.google_project.project.project_id
  role    = "roles/pubsub.publisher"

  members = [
    google_logging_project_sink.sentinel-sink[0].writer_identity
  ]
}

# resource "google_project_iam_binding" "log-writer-organization" {
#   count   = var.organization_id == "" ? 0 : 1
#   project = data.google_project.project.project_id
#   role    = "roles/pubsub.publisher"

#   members = [
#     google_logging_organization_sink.sentinel-organization-sink[0].writer_identity
#   ]
# }