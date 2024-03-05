locals {
  sa_name = var.service_account.name == null ? "fun-${var.name}" : var.service_account.name

  sa_description = var.service_account.description == null ? "User for the Cloud Function: ${var.name}" : var.service_account.description
}

# The user to run the functions as
resource "google_service_account" "this" {
  account_id  = local.sa_name
  description = local.sa_description
}

# Write traces
resource "google_project_iam_member" "tracing" {
  # https://cloud.google.com/trace/docs/iam#roles
  role    = "roles/cloudtrace.agent"
  member  = "serviceAccount:${google_service_account.this.email}"
  project = data.google_project.this.project_id
}
