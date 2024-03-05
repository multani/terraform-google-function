resource "google_cloudfunctions2_function" "this" {
  name        = var.name
  description = var.description
  location    = var.location

  build_config {
    runtime     = var.runtime
    entry_point = var.entry_point

    source {
      storage_source {
        bucket = var.source_code.bucket
        object = var.source_code.object
      }
    }
  }

  service_config {
    # The service account to run the function as
    service_account_email = google_service_account.this.email

    timeout_seconds    = 60
    available_memory   = "${var.available_memory}Mi"
    max_instance_count = var.max_instance_count

    environment_variables = var.environment_variables
  }

  dynamic "event_trigger" {
    for_each = var.event_trigger == null ? [] : [var.event_trigger]

    content {
      event_type   = event_trigger.value.event_type
      pubsub_topic = event_trigger.value.pubsub_topic

      service_account_email = (
        event_trigger.value.service_account_email == null ?
        google_service_account.this.email :
        event_trigger.value.service_account_email
      )

      retry_policy = event_trigger.value.retry_policy
      trigger_region = (
        event_trigger.value.trigger_region == null ?
        var.location :
        event_trigger.value.trigger_region
      )
    }
  }
}
